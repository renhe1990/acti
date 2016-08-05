require 'rails_helper'

describe Weixin::AttemptsController, :type => :controller do
  let(:user) { create(:user) }
  let(:questionnaire) { create(:questionnaire) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new, questionnaire_id: questionnaire.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template 'new' }
  end
end
