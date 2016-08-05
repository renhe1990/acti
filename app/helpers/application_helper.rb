module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def selected(type = :project)
    content_for :selected, type
  end

  def calendar_title
    ->(start_date) {
      content_tag :span, I18n.l(start_date, format: :calendar_title)
    }
  end

  def calendar_previous_link
    ->(param, date_range) {
      link_to '上一月', { param => date_range.first - 1.day }, class: 'pull-left'
    }
  end

  def calendar_next_link
    ->(param, date_range) {
      link_to '下一月', { param => date_range.last + 1.day }, class: 'pull-right'
    }
  end

  def date_of(datetime)
    datetime.strftime("%Y-%m-%d") if datetime
  end

  def time_of(datetime)
    datetime.strftime("%H:%M") if datetime
  end

  def qrcode_filename(course, survey)
    [survey.name, '二维码', course.starts_at.strftime("%Y%m%d")].join("_")
  end

  def qrcode_tag(url, filename = nil, image_options = {})
    link_to download_qrcode_url(url: url, filename: filename) do
      image_tag qrcode_url(url: url, format: :png), { style: 'width: 200px', class: 'img-responsive' }.merge(image_options)
    end
  end
end
