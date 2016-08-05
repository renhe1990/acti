require 'rails_helper'

describe Admin::OpinionnairesController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:project) { create(:project) }
  let(:campaign) { create(:campaign, project: project) }
  let(:course) { create(:course, campaign: campaign) }
  let(:opinionnaire) { create(:opinionnaire, course: course, questions_attributes: [attributes_for(:rating_question, weight: 100)]) }
  let(:valid_attributes) { attributes_for(:opinionnaire, questions_attributes: [attributes_for(:rating_question, weight: 100)]) }

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
        post :create, opinionnaire: valid_attributes, course_id: course.id
      end
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to(admin_course_opinionnaire_path(course, Opinionnaire.last)) }
    end

    context "with invalid attributes" do
      before do
        post :create, opinionnaire: valid_attributes.merge(name: nil), course_id: course.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('new') }
    end
  end

  describe "GET #show" do
    context "when in html format" do
      before do
        get :show, id: opinionnaire.id, course_id: course.id
      end
      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template 'show' }
    end
    context "when in xls format" do
      before do
        get :show, id: opinionnaire.id, course_id: course.id, format: :xls
      end
      it { is_expected.to respond_with(200) }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: opinionnaire.id, course_id: course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: opinionnaire.id, opinionnaire: valid_attributes.merge(questions_attributes: nil), course_id: course.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_course_opinionnaire_path(course, opinionnaire)) }
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, id: opinionnaire.id, course_id: course.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_course_opinionnaires_path(course)) }
  end
end
