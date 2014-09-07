class Article < Sequel::Model

  plugin :nested_attributes

  one_through_one :image, join_table: :hero_images
  nested_attributes :image

  attr_accessor :image, :hero_image, :attrs
  def initialize(attrs = {})
    @attrs = attrs
    @hero_image = HeroImage.new
    add_image
    super(attrs)
  end

  def save(super_proc = ->{ super })
    return upload_image(super_proc) if image?
    super_proc.call
  end

  private

  def image?
    !!image.file
  end

  def upload_image(super_proc)
    image.upload!
    hero_image.image_id = image.id
    super_proc.call
    hero_image.article_id = id
    hero_image.save
  end

  def add_image
    @image       = Image.new
    image_attrs  = attrs.fetch('image_attributes') { return }
    @image.title = image_attrs['0']['title']
    @image.file  = image_attrs['0']['file']
    attrs.reject! { |k| k == 'image_attributes' }
  end

  # attr_reader :instance, :split_meth, :args
  # def method_missing(meth, *args, &block)
  #   @args       = args
  #   @split_meth = meth.to_s.split('_')
  #   @instance   = split_meth[0]
  #   super unless INSTANCES.include?(instance)
  #   send_instance_method
  # end

  # attr_reader :instance_meth, :instance_obj
  # def send_instance_method
  #   @instance_meth = split_meth[1..-1].join('_')
  #   @instance_obj  = self.send(instance.to_sym)
  #   raise_no_method_error unless instance_obj.respond_to?(instance_meth)
  #   method_is_setter? ? send_setter_method : send_getter_method
  # end

  # def send_setter_method
  #   instance_obj.send(instance_meth.to_sym, args[0])
  # end

  # def send_getter_method
  #   saved_instance = self.send("saved_#{ instance }".to_sym)
  #   saved_instance ? saved_instance.values[instance_meth.to_sym] : ''
  # end

  # def method_is_setter?
  #   instance_meth.match(/\=/)
  # end

  # def raise_no_method_error
  #   raise(NoMethodError, "#{ instance } doesn't respond to `#{ instance_meth }`")
  # end

  # class NoMethodError < StandardError; end
end