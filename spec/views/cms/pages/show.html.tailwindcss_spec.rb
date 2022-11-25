require 'rails_helper'

RSpec.describe "cms/pages/show", type: :view do
  before(:each) do
    @cms_page = assign(:cms_page, Cms::Page.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
