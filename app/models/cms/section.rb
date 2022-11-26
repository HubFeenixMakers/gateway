module Cms
  class Section
    include ActiveModel::Model
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    attr_reader :name , :content , :page

    def persisted?
      false
    end

    def initialize(page , section_data)
      @page = page
      @content = section_data
      # id = SecureRandom.hex(10) if new or not there
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
