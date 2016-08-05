require 'rails_helper'

RSpec.describe SearchesController, :type => :controller do
  let(:user) { create(:user, role: lecturer_role) }
  let!(:course) { create :course, name: 'Course Name', user: user }
  let!(:public_course) { create :course, public: true, name: 'Public Course Name' }
  let!(:questionnaire) { create :questionnaire, name: 'Questionnaire Name', user: user}
  let!(:poll) { create :poll, name: 'Poll Name', user: user}

  before do
    sign_in(user)
  end

  describe 'GET #index' do
    context 'when search courses' do
      before do
        get :index, type: 'course', keyword: 'Name'
      end

      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('index') }
      it { expect(assigns[:searches]).to eq([course]) }
    end

    context 'when search public course' do
      before do
        get :index, type: 'public_course', keyword: 'Name'
      end

      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('index') }
      it { expect(assigns[:searches]).to eq([public_course]) }
    end

    context 'when search questionnaires' do
      before do
        get :index, type: 'questionnaire', keyword: 'Name'
      end

      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('index') }
      it { expect(assigns[:searches]).to eq([questionnaire]) }
    end

    context 'when search polls' do
      before do
        get :index, type: 'poll', keyword: 'Name'
      end

      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template('index') }
      it { expect(assigns[:searches]).to eq([poll]) }
    end
  end
end
