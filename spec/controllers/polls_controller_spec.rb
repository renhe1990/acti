require 'rails_helper'

describe PollsController, :type => :controller do
  let(:user) { create(:user, role: lecturer_role) }
  let(:course) { create(:course, user: user) }
  let(:poll) { create(:poll, course: course) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new, course_id: course.id
    end
    it { is_expected.to render_template("new") }
    it { is_expected.to respond_with(200) }
  end

  describe "GET #index" do
    before do
      get :index, course_id: course.id
    end
    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template("index") }
  end

  describe "GET #show" do
    context "when in html format" do
      before do
        get :show, id: poll.id, course_id: course.id
      end
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template 'show' }
    end
    context "when in xls format" do
      before do
        get :show, id: poll.id, course_id: course.id, format: :xls
      end
      it { is_expected.to respond_with 200 }
    end
  end

  describe "GET #edit" do
    before do
      get :edit, id: poll.id, course_id: course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template("edit") }
  end
end
