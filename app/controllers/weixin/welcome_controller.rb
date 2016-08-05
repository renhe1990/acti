class Weixin::WelcomeController < Weixin::BaseController
  def index
    @features = Feature.where(project: nil).order("position ASC")
    @banners = Banner.where(project: nil).order("position ASC")
  end
end
