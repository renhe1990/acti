class Menu < DatabaseConnection
  mount_uploader :image, IconUploader

  default_scope { order('position ASC') }
  has_ancestry

  validates :name, presence: true

  enum category: { view: 0, click: 1 }

  validate do
    if self.root?
      errors.add(:base, '最多包括3个一级菜单') unless Menu.can_create_root_menu?
    else
      errors.add(:base, '最多包括5个二级菜单') unless parent.can_create_child_menu?
    end
  end

  def self.publish
    begin
      Wechat.api.menu_delete
      Wechat.api.menu_create Menu.build_wechat_json
    rescue Exception => e
      return nil
    end
     true
  end

  def self.policy_class
    ApplicationPolicy
  end

  def self.can_create_root_menu?
    Menu.roots.length < 3
  end

  def self.build_wechat_json
    {
      "button" => Menu.roots.inject([]) do |array, root|
        array << root.to_wechat_json
      end
    }
  end

  def to_wechat_json
    if self.root?
      self.to_root_button
    elsif self.click?
      self.to_click_button
    elsif self.view?
      self.to_view_button
    end
  end

  def to_root_button
    if self.children.length > 0
      { "name" => self.name, "sub_button" => self.children.map(&:to_wechat_json) }
    else
      { "name" => self.name }
    end
  end

  def to_click_button
    { "name" => self.name, "type" => "click", "key" => self.id.to_s }
  end

  def to_view_button
    { "name" => self.name, "type" => "view", "url" => self.url }
  end

  def can_create_child_menu?
    self.children.length <= 5
  end
end
