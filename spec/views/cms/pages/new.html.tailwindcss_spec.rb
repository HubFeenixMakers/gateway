require 'rails_helper'

RSpec.describe "cms/pages/new", type: :view do
  before(:each) do
    assign(:cms_page, Cms::Page.new())
  end

  it "renders new cms_page form" do
    render

    assert_select "form[action=?][method=?]", cms_pages_path, "post" do
    end
  end
end
