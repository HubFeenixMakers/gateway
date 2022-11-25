module Cms
  class PagesController < CmsController
    before_action :set_page, only: %i[ show edit update destroy ]

    # GET /cms/pages
    def index
      @pages = Cms::Page.all
    end

    # GET /cms/pages/1
    def show
    end

    # GET /cms/pages/new
    def new
      @page = Cms::Page.new
    end

    # GET /cms/pages/1/edit
    def edit
    end

    # POST /cms/pages
    def create
      @page = Cms::Page.new(page_params)

      if @page.save
        redirect_to @page, notice: "Page was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /cms/pages/1
    def update
      if @page.update(page_params)
        redirect_to @page, notice: "Page was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /cms/pages/1
    def destroy
      @page.destroy
      redirect_to page_url, notice: "Page was successfully destroyed."
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Cms::Page.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def page_params
        params.fetch(:page, {})
      end
  end
end
