class DrawResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :draw
  belongs_to :draw_item

  before_create :draw_randomly

  scope :with_draw_item, ->(draw_item) { where(draw_item: draw_item) }

  def draw_randomly
    draw_items = draw.available_draw_items
    count = draw.users.count - draw.draw_results.count - draw_items.count

    array = Array.new(count > 0 ? count : 0, nil)
    array << draw_items

    self.draw_item = array.flatten.sample
  end
end
