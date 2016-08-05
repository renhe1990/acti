class Project < ActiveRecord::Base
  has_ancestry orphan_strategy: :rootify

  include Searchable
  include Sortable

  mount_uploader :wechat_background, ImageUploader

  validates :name, presence: true

  has_many :campaigns, dependent: :destroy

  has_many :participations, as: :participateable, dependent: :delete_all
  has_many :users, through: :participations

  has_many :features, dependent: :delete_all
  has_many :cells, dependent: :delete_all
  has_many :banners, dependent: :delete_all

  has_many :project_lecturers, dependent: :delete_all
  has_many :lecturers, through: :project_lecturers

  scope :active, -> { where(active: true) }

  extend Enumerize
  enumerize :template, in: [:mode01, :mode02, :mode03, :mode04, :mode05, :mode06]

  accepts_nested_attributes_for :users

  after_commit :copy_root_cells, on: :create

  def copy
    transaction do
      cloned = deep_clone include: { campaigns: [ schedules: :events ] }
      cloned.users = self.users
      cloned.parent = self
      cloned.name = guess_name_for_copy
      return nil unless cloned.save

      self.banners.each do |banner|
        dup = banner.dup
        dup.image = File.open(banner.image.path) if banner.image.path.present?
        cloned.banners << dup
      end

      self.features.each do |feature|
        dup = feature.dup
        dup.video = File.open(feature.video.path) if feature.video.path.present?
        dup.video_screenshot = File.open(feature.video_screenshot.path) if feature.video_screenshot.path.present?
        dup.cover = File.open(feature.cover.path) if feature.cover.path.present?

        cloned.features << dup
      end

      cloned.features.each_with_index do |feature, index|
        next if features[index].blank?

        features[index].photos.each do |photo|
          dup = photo.dup
          dup.photoable = feature
          dup.image = File.open(photo.image.path) if photo.image.path.present?
          dup.save
        end
      end

      self.cells.each do |cell|
        dup = cell.dup
        dup.icon = File.open(cell.icon.path) if cell.icon.path.present?

        cloned.cells << dup
      end

      cloned.campaigns.each_with_index do |campaign, index|
        next if campaigns[index].blank?

        # assume the courses have the same order in the original and cloned campaign
        campaigns[index].courses.each do |course|
          c = course.deep_clone include: [
                                            :lessons, :attachments, :users,
                                            opinionnaires: [:users, :opinionnaire_reviewees, :questions]
                                          ]
          c.draws = course.deep_clone(include: { draws: [:users, :draw_items]}).draws
          c.votes = course.deep_clone(include: { votes: { vote_items: :vote_item_options } }).votes
          c.surveys = course.deep_clone(include: { surveys: [:users, questions: [:options]] }).surveys
          c.lecturers = course.lecturers
          c.campaign = campaign
          c.save
        end
      end

      cloned
    end
  end

  def self.policy_class
    ApplicationPolicy
  end

  def self.admin_search(keyword, options = {})
    by_keyword(keyword)
  end

  private
  def guess_name_for_copy
    number = if self.children.count == 0
               self.children.count + 1
             else
               numbers = self.children.map do |child|
                 match = child.name.scan(/副本(\d+)/).last
                 if match
                   match.last.to_i
                 else
                   nil
                 end
               end.compact
               if numbers.blank?
                 1
               else
                 ((1..numbers.last).to_a - numbers).first || numbers.last + 1
               end
             end
    "#{self.name}副本#{number.to_s.rjust(2, '0')}"
  end

  def copy_root_cells
    self.cells = Cell.root.map(&:dup) if self.cells.blank?
  end
end
