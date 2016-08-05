class Weixin::EventsController < Weixin::BaseController
  before_action :weixin_signed_in_required, only: [:index]
  before_action :weixin_binded_required, only: [:index]

  def index
    if current_user.admin?
      @events = (Survey::Survey.all + Draw.all + Vote.all).sort_by(&:created_at)
    else
      @events = current_user.participations.reject{|participation|
        participation.participateable_type == 'Project' || participation.participateable_type == 'Course' || participation.participateable_type == 'Event'
      }.map(&:participateable).compact
    end

    @events = @events.reject do |event|
      event.course.nil? || event.course.campaign.nil? || event.course.campaign.project.nil?
    end
  end

end
