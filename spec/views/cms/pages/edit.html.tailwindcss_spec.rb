require 'rails_helper'

RSpec.describe "cms/pages/edit", type: :view do
  before(:each) do
    @cms_page = assign(:cms_page, Cms::Page.create!())
  end

  it "renders the edit cms_page form" do
    render

    assert_select "form[action=?][method=?]", cms_page_path(@cms_page), "post" do
    end
  end
end
