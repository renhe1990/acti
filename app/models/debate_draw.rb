class DebateDraw < Draw
  def create_worksheets(book)
    sheet = book.create_worksheet

    sheet.row(0).push self.title
    sheet.row(1).push self.description


    sheet.row(3).push '学员', '标题', '观点'

    draw_results.includes(:draw_item).joins(:draw_item).each_with_index do |draw_result, index|
      sheet.row(4 + index).push draw_result.user.name, draw_result.draw_item.title, draw_result.draw_item.description
    end
  end
end
