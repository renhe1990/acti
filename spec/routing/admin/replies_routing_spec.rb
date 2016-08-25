require "rails_helper"

RSpec.describe Admin::RepliesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/replies").to route_to("admin/replies#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/replies/new").to route_to("admin/replies#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/replies/1").to route_to("admin/replies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/replies/1/edit").to route_to("admin/replies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/replies").to route_to("admin/replies#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/replies/1").to route_to("admin/replies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/replies/1").to route_to("admin/replies#destroy", :id => "1")
    end

  end
end
