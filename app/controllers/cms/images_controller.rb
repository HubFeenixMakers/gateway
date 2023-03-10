module Cms

  class ImagesController < CmsController

    def index
      @images = Image.all
    end

    def create
      new_image = Image.create_new(params['filename'] , params['image_file'])
      redirect = :cms_images
      if(params[:redirect])
        redirect = params[:redirect].gsub("NEW" ,new_image.name)
        puts "image redirect #{redirect}"
      end
      redirect_to redirect
    end

  end

end
