module Cms

  class ImagesController < CmsController

    def index
      @images = Image.all
    end

    def new
    end

    def create
      Image.save_image(params['filename'] , params['image_file'])
      redirect_to cms_image_index_path
    end

  end

end
