require 'rails_helper'

RSpec.describe Weixin::DebateDrawResultsController, :type => :controller do
  let(:user) { create(:user, uid: 'test') }
  let(:debate_draw) { create(:debate_draw, users: [user]) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new, debate_draw_id: debate_draw.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template 'new' }
  end
end
