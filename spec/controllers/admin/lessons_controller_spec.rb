require 'rails_helper'

describe Admin::LessonsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:schedule) { create(:schedule) }
  let(:lesson) { create(:lesson, schedule: schedule, starts_at: schedule.date, ends_at: schedule.date) }
  let(:valid_attributes) { attributes_for(:lesson) }

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
        post :create, lesson: valid_attributes, schedule_id: schedule.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_schedule_lesson_path(schedule, Lesson.last)) }
    end

    context "with invalid attributes" do
      before do
        post :create, lesson: valid_attributes.merge(name: nil), schedule_id: schedule.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: lesson.id, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: lesson.id, lesson: valid_attributes, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_schedule_lesson_path(schedule, lesson)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: lesson.id, schedule_id: schedule.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_schedule_lessons_path(schedule)) }
  end
end
