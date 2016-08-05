class Draw < ActiveRecord::Base
  include Interactiveable

  default_scope { order("draws.position ASC") }

  validates :title, presence: true

  has_many :draw_items, dependent: :delete_all
  accepts_nested_attributes_for :draw_items,
    reject_if: ->(draw_item) { draw_item[:title].blank? },
    allow_destroy: true

  has_many :draw_results, dependent: :delete_all

  def self.policy_class
    ApplicationPolicy
  end

  def available_draw_items
    draw_items.map do |draw_item|
      Array.new((draw_item.quantity || 1) - draw_results.where(draw_item_id: draw_item.id).count, draw_item)
    end.flatten
  end

  def self.admin_search(keyword, options = {})
    with_admin_course.where("LOWER(draws.title) LIKE ?", "%#{keyword.downcase}%").includes(course: { :campaign => :project }).joins(course: { :campaign => :project })
  end
end
