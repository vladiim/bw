class Article < Sequel::Model

  attr_accessor :image, :hero_image

  def initialize(attrs={})
    @image = Image.new
    @hero_image = HeroImage.new
    super(attrs)
  end

  def image_title=(title)
    image.title = title
  end

  def image_file=(file)
    image.file = file
  end

  def save(super_proc = ->{ super })
    image.upload!
    hero_image.image_id = image.id
    super_proc.call
    hero_image.article_id = @values[:id]
    hero_image.save
  end

  # add image finder for when editing an article
end