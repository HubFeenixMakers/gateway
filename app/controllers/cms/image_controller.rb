module Cms

  class ImageController < ApplicationController

    @@root = "app/assets/images/cms/"
    @@files = Dir.new(Rails.root + @@root).children

    def index
      @files = files
    end

    private

    def files
      @@files
    end
  end

end
