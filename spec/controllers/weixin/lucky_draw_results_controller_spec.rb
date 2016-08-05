require 'rails_helper'

RSpec.describe Weixin::LuckyDrawResultsController, :type => :controller do
  let(:user) { create(:user, uid: 'test') }
  let(:lucky_draw) { create(:lucky_draw, users: [user]) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new, lucky_draw_id: lucky_draw.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template 'new' }
  end
end
