class User < ActiveRecord::Base
  acts_as_paranoid

  enum gender: { male: 0, female: 1 }
  enum status: { incomplete: 0, complete: 1, deleted: 2 }
  enum diet: { 无忌口: 0, 素食: 1, 清真: 2 }

  has_secure_password

  validates :card_number, presence: true, uniqueness: true
  validates :name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates_email_format_of :email, message: '无效的电子邮箱'
  validates :password, confirmation: true, on: :create

  belongs_to :province
  belongs_to :city
  belongs_to :role
  belongs_to :area
  belongs_to :grade

  has_many :questionnaires
  has_many :polls
  has_many :courses
  has_many :lessons

  has_many :reviews, as: :reviewable
  has_many :authored_reviews, as: :reviewer, class_name: 'Review'

  has_many :participations

  has_many :project_lecturers, source_type: :user, foreign_key: :lecturer_id

  scope :by_keyword, ->(keyword) { where("name LIKE ? OR card_number LIKE ?", "%#{keyword}%", "%#{keyword}%") }
  scope :by_role, ->(role_id) { where(role_id: role_id) }
  scope :by_area, ->(area_id) { where(area_id: area_id) }
  scope :by_grade, ->(grade_id) { where(grade_id: grade_id) }
  scope :by_gender, ->(gender) { where(gender: gender) }
  scope :by_status, ->(status) { where(status: status) }
  scope :by_uid, ->(uid) { where(uid: uid) }

  before_save :update_status
  before_destroy :set_status_to_deleted
  after_restore :update_status_and_save

  FILEDS_FOR_STATUS = %w(uid role gender)
  MARK = 'ACTI用户批量导入（本行为识别行，请勿删除）'

  def participated_projects
    Project.where(id: participations.where(participateable_type: 'Project').map(&:participateable_id)).all
  end

  def joined_projects
    Project.where(id: project_lecturers.where(lecturer: self).map(&:project_id)).all
  end

  def admin?
    return false if role.nil?

    role.name == '管理员'
  end

  def teacher?
    return false if role.nil?

    role.name == '区域讲师' || role.name == '地方讲师'
  end

  def student?
    return false if role.nil?

    role.name == '特定学员'
  end

  def status_to_s
    case status.to_sym
    when :complete then '正常'
    when :incomplete then '缺少信息'
    when :deleted then '冻结'
    end
  end

  def gender_to_s
    return '/' unless gender.present?

    case gender.to_sym
    when :male
      '男'
    when :female
      '女'
    else
      '/'
    end
  end

  def self.lecturers
    User.joins(:role).where("roles.name = '区域讲师' OR roles.name = '地方讲师'").all
  end

  def self.authenticate(card_number, password)
    user = User.with_deleted.where(card_number: card_number).first
    if user
      user.authenticate(password)
    else
      false
    end
  end

  def self.authenticate_or_create_with_wechat(wechat_user)
    User.authenticate_with_wechat(wechat_user) || User.create_with_wechat(wechat_user)
  end

  def self.authenticate_with_wechat(wechat_user)
    User.where(provider: 'wechat', uid: wechat_user['openid']).first
  end

  def self.create_with_wechat(wechat_user)
    User.new.tap do |user|
      user.provider = 'wechat'
      user.uid = wechat_user['openid']
      user.name = wechat_user['nickname']
    end.save(validate: false)
  end

  def self.search(keyword, options = {})
    scoping = User.includes(:role, :area, :grade)
    scoping = scoping.by_keyword(keyword) if keyword.present?
    scoping = scoping.by_role(options[:role_id]) if options[:role_id].present?
    scoping = scoping.by_area(options[:area_id]) if options[:area_id].present?
    scoping = scoping.by_grade(options[:grade_id]) if options[:grade_id].present?
    scoping = scoping.by_status(User.statuses[options[:status]]) if options[:status].present?
    scoping = scoping.by_gender(options[:gender]) if options[:gender].present?
    scoping = scoping.with_deleted if options[:with_deleted].present?
    scoping.page(options[:page])
  end

  def review_from(reviewer, context = nil)
    reviews.where(reviewer: reviewer, context: context).first
  end

  def reviewed_by?(reviewer, context = nil)
    !!review_from(reviewer, context)
  end

  def self.import(file, options = {})
    return [] unless file

    users = []
    spreadsheet = open_spreadsheet(file)
    return [] unless spreadsheet.row(1).first == MARK

    if options[:role_id].present?
      role = Role.find(options[:role_id])
    end

    transaction do
      users = 3.upto(spreadsheet.last_row).map do |i|
        row = spreadsheet.row(i)
        role_name = row[9].gsub(/\s+/,'').eql?('评委') ? '地方讲师' : row[9]
        if role && role.name != role_name
          nil
        else
          User.create_with({
            role: Role.find_or_create_by(name: role_name),
            password: row[8].to_i.to_s.strip,
            password_confirmation: row[8].to_i.to_s.strip,
            gender: case row[7].gsub(/\s+/,'')
                    when '男' then 'male'
                    when '女' then 'female'
                    end,
            name: row[4].gsub(/\s+/,''),
            city: row[3].present? ? City.where("LOWER(name) like ?", "%#{row[3].gsub(/\s+/,'').downcase}%").first : nil,
            province: row[2].present? ? Province.where("LOWER(name) like ?", "%#{row[2].gsub(/\s+/,'').downcase}%").first : nil,
            area: row[1].present? ? Area.find_or_create_by(name: row[1].gsub(/\s+/,'')) : nil
          }).find_or_create_by(card_number: row[5].to_i.to_s.gsub(/\s+/,'').strip)
        end
      end.compact
    end
    return users
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  private
  def update_status_and_save
    self.reload
    update_status
    save
  end

  def update_status
    if self.deleted_at.present?
      self.status = User.statuses[:deleted]
      return
    end

    FILEDS_FOR_STATUS.each do |field|
      if self.send(field).nil?
        self.status = User.statuses[:incomplete]
        return
      end
    end

    self.status = User.statuses[:complete]
  end

  def set_status_to_deleted
    self.update_column :status, User.statuses[:deleted]
  end
end
