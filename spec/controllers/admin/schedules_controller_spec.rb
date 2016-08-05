require 'rails_helper'

describe Admin::SchedulesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:campaign) { create(:campaign) }
  let(:schedule) { create(:schedule, campaign: campaign) }
  let(:valid_attributes) { attributes_for(:schedule) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index, campaign_id: campaign.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end

  describe "GET #new" do
    before do
      get :new, campaign_id: campaign.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, schedule: valid_attributes, campaign_id: campaign.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_campaign_schedule_path(campaign, Schedule.last)) }
    end

    context "with invalid attributes" do
      before do
        post :create, schedule: valid_attributes.merge(title: nil), campaign_id: campaign.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: schedule.id, campaign_id: campaign.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: schedule.id, schedule: valid_attributes, campaign_id: campaign.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_campaign_schedule_path(campaign, schedule)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: schedule.id, campaign_id: campaign.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_campaign_schedules_path(campaign)) }
  end
end
