module Cms
  class SectionsController < CmsController
    before_action :set_page, only: %i[ show edit update destroy ]


    private
    def set_page
      @page = Page.find(params[:page_id])
      @section = @page.find_section( params[:id] )
    end

  end
end
