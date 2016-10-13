require 'rails_helper'

RSpec.describe "admin/replies/index", :type => :view do
  before(:each) do
    assign(:admin_replies, [
      Admin::Reply.create!(
        :category => "Category",
        :data => "MyText"
      ),
      Admin::Reply.create!(
        :category => "Category",
        :data => "MyText"
      )
    ])
  end

  it "renders a list of admin/replies" do
    render
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
