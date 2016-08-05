require 'rails_helper'

describe PublicCoursesController, :type => :controller do
  let(:user) { create(:user, role: lecturer_role) }
  let(:course) { create(:course, user: user, public: true) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template("index") }
  end


  describe "GET #show" do
    before do
      get :show, id: course.id
    end

    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template("show") }
  end

  describe "POST #copy" do
    before do
      post :copy, id: course.id
    end

    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to([:edit, Course.order("id DESC").first]) }
  end
end
