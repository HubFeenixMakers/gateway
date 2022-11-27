module Cms
  class Section
    include ActiveModel::Model
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    attr_reader :name , :content , :page , :index

    def persisted?
      false
    end

    def initialize(page , index , section_data)
      @page = page
      raise "No number #{index}" unless index.is_a?(Integer)
      raise "No has #{section_data}" unless section_data.is_a?(Hash)
      @index = index
      @content = section_data
    end

    def template
      @content["template"]
    end

    def id
      @content["id"]
    end

    def save
      false
    end

    def self.all
      @page.sections
    end

    def self.find(page_name , section_id)
      Page.new(name + ".yaml")
    end

  end
end
