require 'rails_helper'

describe Admin::ProjectsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:project) { create(:project) }
  let(:valid_project_attributes) { attributes_for(:project) }
  let(:invalid_project_attributes) { attributes_for(:project, name: nil) }

  before do
    sign_in(user)
  end

  describe "GET #new" do
    before do
      get :new
    end
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template 'new' }
  end

  describe "POST #create" do
    def send_request(attributes)
      post :create, project: attributes
    end

    context "with valid attributes" do
      before do
        send_request valid_project_attributes
      end

      it { is_expected.to respond_with :redirect }
      it { is_expected.to redirect_to(admin_project_url(Project.first)) }
    end

    context "with invalid attributes" do
      before do
        send_request invalid_project_attributes
      end

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template 'new' }
    end
  end

  describe "GET #show" do
    before do
      get :show, id: project.id
    end
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template 'show' }
  end

  describe "GET #edit" do
    before do
      get :edit, id: project.id
    end
    it { is_expected.to respond_with :success }
    it { is_expected.to render_template("edit") }
  end

  describe "POST #copy" do
    before do
      post :copy, id: project.id
    end
    it { is_expected.to respond_with 302 }
  end
end
