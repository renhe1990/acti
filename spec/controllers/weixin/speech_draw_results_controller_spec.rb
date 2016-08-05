require 'rails_helper'

RSpec.describe Weixin::SpeechDrawResultsController, :type => :controller do
  let(:user) { create(:user, uid: 'test') }
  let(:speech_draw) { create(:speech_draw, users: [user]) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new, speech_draw_id: speech_draw.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template 'new' }
  end
end
