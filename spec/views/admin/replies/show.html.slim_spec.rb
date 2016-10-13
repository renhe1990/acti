require 'rails_helper'

RSpec.describe "admin/replies/show", :type => :view do
  before(:each) do
    @admin_reply = assign(:admin_reply, Admin::Reply.create!(
      :category => "Category",
      :data => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/MyText/)
  end
end
