require 'rails_helper'

describe Admin::FeaturesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:feature) { create(:feature) }
  let(:valid_attributes) { attributes_for(:feature) }

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
        post :create, feature: valid_attributes
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_feature_path(Feature.first)) }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: feature.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: feature.id, feature: valid_attributes
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_feature_path(feature)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: feature.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_features_path) }
  end
end
