ActiveRecord::Base.class_eval do
  def to_xls
    book = Spreadsheet::Workbook.new

    create_worksheets(book)

    buffer = StringIO.new
    book.write(buffer)
    buffer.rewind
    buffer.read
  end

  protected

    def create_worksheets(book)
      raise "Must be implemented in subclass."
    end
end
