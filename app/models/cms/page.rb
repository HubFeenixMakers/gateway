module Cms
  class Page
    include ActiveModel::Model
    include ActiveModel::Conversion
    include ActiveModel::Dirty

    @@files = Set.new Dir.new(Rails.root.join("cms")).children

    attr_reader :name , :content

    def persisted?
      false
    end

    def initialize file_name
      @name = file_name.split(".").first
      @content = YAML.load_file(Rails.root.join("cms" , file_name))
    end

    def sections
      @content.collect{|section_data| Section.new(self , section_data)}
    end

    def find_section(section_id)
      content = @content.find{|section| section["id"] == section_id }
      Section.new(self , content)
    end

    def first_template
      @content[0]["template"]
    end

    def new_section
      section = Hash.new
      section['id'] = SecureRandom.hex(10)
      @content << section
      Section.new(self , section)
    end

    def save
      file_name = Rails.root.join("cms" , name + ".yaml")
      File.write( file_name , @content.to_yaml)
    end

    def self.all
      @@files.collect{ |file| Page.new(file) }
    end

    def self.find(name)
      Page.new(name + ".yaml")
    end

  end
end
