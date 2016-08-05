require 'rails_helper'

describe Admin::CampaignsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:project) { create(:project) }
  let(:campaign) { create(:campaign, project: project) }
  let(:valid_attributes) { attributes_for(:campaign) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index, project_id: project.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end

  describe "GET #new" do
    before do
      get :new, project_id: project.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, campaign: valid_attributes, project_id: project.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_project_campaign_path(project, Campaign.first)) }
    end

    context "with invalid attributes" do
      before do
        post :create, campaign: valid_attributes.merge(name: nil), project_id: project.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: campaign.id, project_id: project.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: campaign.id, campaign: valid_attributes, project_id: project.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_project_campaign_path(project, campaign)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: campaign.id, project_id: project.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_project_campaigns_path(project)) }
  end
end
