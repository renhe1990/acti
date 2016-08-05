module Weixin::CellsHelper
  def cell_path(cell, options = {})
    cell.editable? ? weixin_cell_path(cell, options) : cell.url.gsub(/project_id/, cell.project.id.to_s)
    if cell.editable?
      weixin_cell_path(cell, options)
    else
      uri = URI cell.url.gsub(/project_id/, cell.project.id.to_s)
      uri.query = URI.encode_www_form(options)
      uri.to_s
    end
  end

  def link_to_cell(cell, background_color = nil, options = {})
    link_to cell_path(cell, title: cell.title) do
      content_tag :div, class: 'center-block', style: "background-color: #{background_color}" do
        if options[:icon_wrapper]
          concat content_tag(:div, image_tag(cell.icon.url, class: 'icon'), class: 'icon-wrapper')
        else
          concat image_tag(cell.icon.url, class: 'icon')
        end

        if options[:vertical]
          0.upto(cell.title.length - 1).each do |index|
            concat content_tag(:div, cell.title[index], class: 'title')
          end
        else
          concat content_tag(:div, cell.title, class: 'title')
        end
      end
    end
  end
end
