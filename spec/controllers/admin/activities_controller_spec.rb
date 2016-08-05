require 'rails_helper'

describe Admin::ActivitiesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:schedule) { create(:schedule) }
  let(:activity) { create(:activity, schedule: schedule, starts_at: schedule.date, ends_at: schedule.date) }
  let(:valid_attributes) { attributes_for(:activity, starts_at: schedule.date, ends_at: schedule.date) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end

  describe "GET #new" do
    before do
      get :new, schedule_id: schedule.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, activity: valid_attributes, schedule_id: schedule.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_schedule_activity_path(schedule, Activity.last)) }
    end

    context "with invalid attributes" do
      before do
        post :create, activity: valid_attributes.merge(name: nil), schedule_id: schedule.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: activity.id, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: activity.id, activity: valid_attributes, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_schedule_activity_path(schedule, activity)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: activity.id, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_schedule_activities_path(schedule)) }
  end
end
