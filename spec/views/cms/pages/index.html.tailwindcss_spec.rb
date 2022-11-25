require 'rails_helper'

RSpec.describe "cms/pages/index", type: :view do
  before(:each) do
    assign(:cms_pages, [
      Cms::Page.create!(),
      Cms::Page.create!()
    ])
  end

  it "renders a list of cms/pages" do
    render
  end
end
