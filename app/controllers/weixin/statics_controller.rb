class Weixin::StaticsController < Weixin::BaseController
  def show
    render params[:id]
  end

end
