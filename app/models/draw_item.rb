class DrawItem < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :draw
  has_many :draw_results

  acts_as_list scope: :draw

  def users
    self.draw.draw_results.with_draw_item(self).map(&:user)
  end
end
