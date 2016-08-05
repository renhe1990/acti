class LuckyDraw < Draw
  def self.policy_class
    ApplicationPolicy
  end

  def available_lucky_draw_items
    lucky_draw_items.map do |lucky_draw_item|
      Array.new(lucky_draw_item.quantity - lucky_draw_results.where(lucky_draw_item_id: lucky_draw_item.id).count, lucky_draw_item)
    end.flatten
  end

  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push self.title
    sheet.row(1).push self.description


    sheet.row(3).push '学员', '名称'

    draw_results.includes(:draw_item).joins(:draw_item).each_with_index do |draw_result, index|
      sheet.row(4 + index).push draw_result.user.name, draw_result.draw_item.title
    end
  end
end
