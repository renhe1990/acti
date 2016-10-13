require 'rails_helper'

RSpec.describe "Admin::Replies", :type => :request do
  describe "GET /admin_replies" do
    it "works! (now write some real specs)" do
      get admin_replies_path
      expect(response.status).to be(200)
    end
  end
end
