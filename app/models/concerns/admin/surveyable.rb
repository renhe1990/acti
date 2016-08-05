module Admin::Surveyable
  extend ActiveSupport::Concern
  include Interactiveable

  included do
    default_scope { order("survey_surveys.position ASC") }
  end

  module ClassMethods
    def admin_search(keyword, options = {})
      with_admin_course.where("LOWER(survey_surveys.name) LIKE ?", "%#{keyword.downcase}%").includes(:course => { :campaign => :project }).joins(:course => { :campaign => :project })
    end
  end
end


