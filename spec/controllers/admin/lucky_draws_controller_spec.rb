require 'rails_helper'

describe Admin::LuckyDrawsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:course) { create(:course) }
  let(:lucky_draw) { create(:lucky_draw, course: course) }
  let(:valid_attributes) { attributes_for(:lucky_draw) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index, course_id: course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end

  describe "GET #new" do
    before do
      get :new, course_id: course.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, lucky_draw: valid_attributes, course_id: course.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_course_lucky_draw_path(course, LuckyDraw.last)) }
    end

    context "with invalid attributes" do
      before do
        post :create, lucky_draw: valid_attributes.merge(title: nil), course_id: course.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #show" do
    context "when in html format" do
      before do
        get :show, id: lucky_draw.id, course_id: course.id
      end
      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template 'show' }
    end
    context "when in xls format" do
      before do
        get :show, id: lucky_draw.id, course_id: course.id, format: :xls
      end
      it { is_expected.to respond_with(200) }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: lucky_draw.id, course_id: course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: lucky_draw.id, lucky_draw: valid_attributes, course_id: course.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_course_lucky_draw_path(course, lucky_draw)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: lucky_draw.id, course_id: course.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_course_lucky_draws_path(course)) }
  end
end
