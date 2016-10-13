require 'rails_helper'

RSpec.describe "admin/replies/edit", :type => :view do
  before(:each) do
    @admin_reply = assign(:admin_reply, Admin::Reply.create!(
      :category => "MyString",
      :data => "MyText"
    ))
  end

  it "renders the edit admin_reply form" do
    render

    assert_select "form[action=?][method=?]", admin_reply_path(@admin_reply), "post" do

      assert_select "input#admin_reply_category[name=?]", "admin_reply[category]"

      assert_select "textarea#admin_reply_data[name=?]", "admin_reply[data]"
    end
  end
end
