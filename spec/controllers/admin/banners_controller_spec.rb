require 'rails_helper'

describe Admin::BannersController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:banner) { create(:banner) }
  let(:valid_attributes) { attributes_for(:banner) }

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

  describe "GET #new" do
    before do
      get :new
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, banner: valid_attributes
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_banners_path) }
    end

    context "with invalid attributes" do
      before do
        post :create, banner: {}
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: banner.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: banner.id, banner: valid_attributes
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_banners_path) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: banner.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_banners_path) }
  end
end
