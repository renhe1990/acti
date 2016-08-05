module LessonsHelper
  def lesson_time_label(lesson)
    return '' if lesson.starts_at.nil? || lesson.ends_at.nil?

    starts_at, ends_at = lesson.starts_at, lesson.ends_at
    if starts_at.to_date == ends_at.to_date
      "#{starts_at.to_date} == #{ends_at.to_date}"
      "#{ l(starts_at.to_date, format: :long) }, #{ starts_at.strftime("%H:%M") } - #{ ends_at.strftime("%H:%M") }"
    else
      "#{ l(starts_at)} - #{ l(ends_at) }"
    end
  end
end
