module Cms

  class ImagesController < CmsController

    @@root = "app/assets/images/cms/"
    @@files = Set.new Dir.new(Rails.root + @@root).children

    def index
      @files = files
    end

    def new
    end

    def create
      io = params['image_file']
      ending = io.original_filename.split("/").last.split(".").last
      filename = params['filename'] + "." + ending
      File.open(Rails.root.join('app/assets/images/cms', filename), "wb") do |f|
        f.write io.read
      end
      @@files << filename
      redirect_to cms_image_index_path
    end

    private

    def files
      @@files
    end
  end

end
