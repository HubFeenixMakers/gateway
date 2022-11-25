module Cms
  class Page
    include ActiveModel::API
    include ActiveModel::Conversion

    @@files = Set.new Dir.new(Rails.root.join("cms")).children

    attr_reader :name

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

    def self.all
      @@files.collect{ |file| Page.new(file) }
    end
  end
end
