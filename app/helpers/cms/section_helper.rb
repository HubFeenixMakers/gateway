module Cms::SectionHelper

  def section_form(options)
    url = cms_page_section_url( @page.id , @section.id)
    puts "URL #{url}"
    form_tag( url , {method: :patch}) do
      yield
    end
  end
end
