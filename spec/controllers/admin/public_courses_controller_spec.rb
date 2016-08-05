require 'rails_helper'

RSpec.describe Admin::PublicCoursesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:public_course) { create(:public_course) }
  let(:valid_attributes) { attributes_for(:public_course) }

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
        post :create, course: valid_attributes
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_public_course_path(Course.common.first)) }
    end

    context "with invalid attributes" do
      before do
        post :create, course: valid_attributes.merge(name: nil)
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: public_course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: public_course.id, course: valid_attributes
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_public_course_path(public_course)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: public_course.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_public_courses_path) }
  end
end
