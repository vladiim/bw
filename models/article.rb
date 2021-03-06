class Article < Sequel::Model

  plugin :nested_attributes

  one_through_one :image, join_table: :hero_images
  one_through_one :photographer

  nested_attributes :image, :photographer

  attr_reader :attrs, :image, :hero_image, :photographer
  def initialize(attrs = {})
    set_attrs(attrs)
    add_hero_image
    add_photographer
    super
  end

  def save(super_proc = ->{ super })
    return upload_hero_image(super_proc) if hero_image_file?
    super_proc.call
  end

  attr_accessor :saved_hero_image
  def self.find(id)
    article = Article[id]
    article.saved_hero_image = article.image_dataset.first
    article.saved_hero_image ||= NullHeroImage.new
    article
  end

  def hero_image_title
    saved_hero_image ? saved_hero_image.values[:title] : ''
  end

  def hero_image_url
    saved_hero_image ? saved_hero_image.values[:url] : ''
  end

  private

  def set_attrs(attrs)
    @attrs        = attrs
    @hero_image   = HeroImage.new
    @image        = Image.new
    @photographer = Photographer.new
  end


  def add_hero_image
    image_attrs  = attrs.fetch('image_attributes') { return }
    image.title  = image_attrs['0']['title']
    image.file   = image_attrs['0']['file']
    attrs.reject! { |k| k == 'image_attributes' }
  end

  def add_photographer
    photo_attrs =  attrs.fetch('photographer_attributes') { return }
    # @photographer = Photographer.new
    # require 'debugger'; debugger
    photographer.name = photo_attrs['name']
    attrs.reject! { |k| k == 'photographer_attributes' }
  end

  def hero_image_file?
    !!image.file
  end

  def upload_hero_image(super_proc)
    image.upload!
    hero_image.image_id = image.id
    super_proc.call
    hero_image.article_id = id
    hero_image.save
  end
end