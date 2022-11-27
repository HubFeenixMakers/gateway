module Cms
  class Image
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    @@images = {}

    attr_reader :name , :type , :created_at , :updated_at

    def initialize(filename)
      puts filename
      @name , @type = filename.split(".")
      file = File.new(Rails.root.join(Image.root,filename))
      @created_at = file.birthtime
      @updated_at = file.ctime
    end

    def self.all
      return @@images unless @@images.empty?
      Dir[Rails.root.join Image.root + "*.*"].each do |f|
        file = f.split("/").last
        self.add( file )
      end
      @@images
    end

    #save an io with given name (without ending, that is taken from io)
    def self.create_new(filename , io)
      ending = io.original_filename.split("/").last.split(".").last
      full_filename = filename + "." + ending
      File.open(Rails.root.join(Image.root, full_filename), "wb") do |f|
        f.write( io.read )
      end
      self.add( full_filename )
    end

    def self.root
      "app/assets/images/cms/"
    end

    private
    def self.add(filename)
      key = filename.split(".").first
      @@images[key] = Image.new(filename)
    end
  end
end
