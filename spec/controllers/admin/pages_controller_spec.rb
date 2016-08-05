require 'rails_helper'

describe Admin::PagesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:page) { create(:page) }
  let(:valid_attributes) { attributes_for(:page) }

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

  describe "GET #edit" do
    before do
      get :edit, id: page.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: page.id, page: valid_attributes
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_pages_path) }
  end
end
