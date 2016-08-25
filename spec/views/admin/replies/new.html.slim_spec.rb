require 'rails_helper'

RSpec.describe "admin/replies/new", :type => :view do
  before(:each) do
    assign(:admin_reply, Admin::Reply.new(
      :category => "MyString",
      :data => "MyText"
    ))
  end

  it "renders new admin_reply form" do
    render

    assert_select "form[action=?][method=?]", admin_replies_path, "post" do

      assert_select "input#admin_reply_category[name=?]", "admin_reply[category]"

      assert_select "textarea#admin_reply_data[name=?]", "admin_reply[data]"
    end
  end
end
