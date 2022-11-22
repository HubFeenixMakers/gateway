module CmsHelper
  # sectio should be hash with at least 'template' key
  def find_template(section)
    "sections/" + section["template"]
  end

  def bg(section)
    #{'background-image' => url('#{image_url('cms/' + section['image'])}')}
    img = image_url "cms/house.jpg"
    "background-image: url('#{img}');"
  end
end
