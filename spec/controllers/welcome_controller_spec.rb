require 'rails_helper'

describe WelcomeController, :type => :controller do
  let(:user) { create(:user, role: lecturer_role) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end
end
