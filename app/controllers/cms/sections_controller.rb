module Cms
  class SectionsController < CmsController
    before_action :set_page, only: %i[ show edit update destroy ]

    def update
      @section.content.each do |key , value|
        next if key == "id"
        if(!params[key].nil?)
          @section.update(key, params[key])
          puts "updating:#{key}=#{params[key]}"
        end
      end
      @page.save
      redirect_to :cms_page_section
    end

    private
    def set_page
      @page = Page.find(params[:page_id])
      @section = @page.find_section( params[:id] )
    end

  end
end
