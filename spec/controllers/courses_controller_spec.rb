require 'rails_helper'

describe CoursesController, :type => :controller do
  let(:user) { create(:user, role: lecturer_role) }
  let(:course) { create(:course, user: user) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template("new") }
  end

  describe "GET #edit" do
    before do
      get :edit, id: course.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template("edit") }
  end
end

