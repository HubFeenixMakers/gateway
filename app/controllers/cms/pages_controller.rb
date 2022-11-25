class Cms::PagesController < ApplicationController
  before_action :set_cms_page, only: %i[ show edit update destroy ]

  # GET /cms/pages
  def index
    @cms_pages = Cms::Page.all
  end

  # GET /cms/pages/1
  def show
  end

  # GET /cms/pages/new
  def new
    @cms_page = Cms::Page.new
  end

  # GET /cms/pages/1/edit
  def edit
  end

  # POST /cms/pages
  def create
    @cms_page = Cms::Page.new(cms_page_params)

    if @cms_page.save
      redirect_to @cms_page, notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cms/pages/1
  def update
    if @cms_page.update(cms_page_params)
      redirect_to @cms_page, notice: "Page was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cms/pages/1
  def destroy
    @cms_page.destroy
    redirect_to cms_pages_url, notice: "Page was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_page
      @cms_page = Cms::Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cms_page_params
      params.fetch(:cms_page, {})
    end
end
