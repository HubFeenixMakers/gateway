module Cms
  class Page
    include ActiveModel::Model
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    @@files = Set.new Dir.new(Rails.root.join("cms")).children

    attr_reader :name , :content

    def id
      @name
    end

    def persisted?
      false
    end

    def initialize file_name
      @name = file_name.split(".").first
      @content = YAML.load_file(Rails.root.join("cms" , file_name))
    end

    def template
      @content[0]["template"]
    end

    def save
      false
    end

    def self.all
      @@files.collect{ |file| Page.new(file) }
    end

    def self.find(name)
      Page.new(name + ".yaml")
    end

  end
end
