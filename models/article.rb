class Article < Sequel::Model

  INSTANCES = %w( image )

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

  private

  attr_reader :instance, :split_meth, :args
  def method_missing(meth, *args, &block)
    @args       = args
    @split_meth = meth.to_s.split('_')
    @instance   = split_meth[0]
    super unless INSTANCES.include?(instance)
    send_instance_method
  end

  attr_reader :instance_meth, :instance_obj
  def send_instance_method
    @instance_meth = split_meth[1..-1].join('_')
    @instance_obj  = self.send(instance.to_sym)
    raise_no_method_error unless instance_obj.respond_to?(instance_meth)
    method_is_setter? ? send_setter_method : send_getter_method
  end

  def send_setter_method
    instance_obj.send(instance_meth.to_sym, args[0])
  end

  def send_getter_method
    saved_instance = self.send("saved_#{ instance }".to_sym)
    saved_instance ? saved_instance.values[instance_meth.to_sym] : ''
  end

  def method_is_setter?
    instance_meth.match(/\=/)
  end

  def raise_no_method_error
    raise(NoMethodError, "#{ instance } doesn't respond to `#{ instance_meth }`")
  end

  class NoMethodError < StandardError; end
end