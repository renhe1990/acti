class SpeechDraw < Draw
  after_save :adjust_draw_items

  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push self.title
    sheet.row(1).push self.description


    sheet.row(3).push '学员', '标题'

    draw_results.includes(:draw_item).joins(:draw_item).each_with_index do |draw_result, index|
      sheet.row(4 + index).push draw_result.user.name, draw_result.draw_item.title
    end
  end

  def adjust_draw_items
    return unless self.editable?

    users_count = self.users.count
    draw_items_count = self.draw_items.count

    if users_count > draw_items_count
      (draw_items_count + 1).upto(users_count) do |n|
        self.draw_items.create title: "#{n}号"
      end
    else
      self.draw_items[users_count..-1].each(&:destroy)
    end
  end

  def editable?
    self.draw_results.empty?
  end
end
