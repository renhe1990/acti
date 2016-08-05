require 'rails_helper'

describe Admin::CellsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }
  let(:project) { create(:project) }
  let(:cell) { create(:cell, project: project) }
  let(:valid_attributes) { attributes_for(:cell) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    before do
      get :index, project_id: project.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('index') }
  end

  describe "GET #edit" do
    before do
      get :edit, id: cell.id, project_id: project.id
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('edit') }
  end

  describe "PATCH #update" do
    before do
      patch :update, id: cell.id, cell: valid_attributes, project_id: project.id
    end
    it { is_expected.to respond_with 302 }
    it { is_expected.to redirect_to(admin_project_cells_path(project)) }
  end
end
