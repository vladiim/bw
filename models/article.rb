class Article < Sequel::Model

  attr_accessor :image, :hero_image
  def initialize(attrs = {})
    @image      = Image.new
    @hero_image = HeroImage.new
    super(attrs)
  end

  attr_accessor :saved_image, :saved_hero_image
  def self.find(article_id)
    article                  = Article[article_id]
    article.saved_hero_image = HeroImage.first({ article_id: article.id })
    article.saved_image      = Image[article.saved_hero_image.image_id]
    article
  end

  def save(super_proc = ->{ super })
    image.upload!
    hero_image.image_id = image.id
    super_proc.call
    hero_image.article_id = @values[:id]
    hero_image.save
  end

  # def image_title=(title)
  #   image.title = title
  # end

  # def image_file=(file)
  #   image.file = file
  # end

  def image_url
    @saved_image ? @saved_image.values[:url] : ''
  end

  def image_title
    @saved_image ? @saved_image.values[:title] : ''
  end

  def method_missing(meth, *args, &block)
    split_meth    = meth.to_s.split('_')
    instance      = split_meth[0]
    instance_meth = split_meth[1..-1].join('_')
    send_instance_method(instance, instance_meth, args) if self.respond_to?(instance.to_sym)
  end

  private
  def send_instance_method(instance, instance_meth, args)
    instance = self.send(instance.to_sym)
    instance.send(instance_meth.to_sym, args[0]) if instance.respond_to?(instance_meth)
  end
  # add image finder for when editing an article
  # destroy hero image on destroy
end