require 'spec_helper'

describe "Pages" do

  it "should render index" do
    visit_path "/"
    expect(page).to have_text("Gateway")
  end
end
