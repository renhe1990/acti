require 'rails_helper'

describe SessionsController, :type => :controller do
  let(:user) { create(:user, role: admin_role) }

  describe "GET #new" do
    before do
      get :new
    end
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template('new') }
  end

  describe "POST #create" do
    context "with invalid credential" do
      before do
        post :create, user: { card_numer: user.card_number, password: 'wrong password' }
      end
      it { is_expected.to render_template('new') }
    end

    context "when the user is a admin" do
      let(:user) { create(:user, role: admin_role) }
      before do
        post :create, user: { card_number: user.card_number, password: 'password' }
      end
      it { is_expected.to redirect_to [:admin, :root] }
    end

    context "when the user is a lecturer" do
      let(:user) { create(:user, role: lecturer_role) }
      before do
        post :create, user: { card_number: user.card_number, password: 'password' }
      end
      it { is_expected.to redirect_to [:root] }
    end

    context "when the user does not have any role" do
      let(:user) { create(:user) }
      before do
        post :create, user: { card_numer: user.card_number, password: 'password' }
      end
      it { is_expected.to render_template('new') }
    end
  end
end
