module Weixin::CampaignsHelper
  def time_range(starts_at, ends_at)
    format = "%H:%M"
    return starts_at.strftime(format) if starts_at == ends_at

    "#{starts_at.strftime(format)} - #{ends_at.strftime(format)}"
  end
end
