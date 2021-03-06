class Image < Sequel::Model

  one_through_one :article, join_table: :hero_images

  plugin :validation_helpers

  attr_accessor :title, :file, :url, :created_at

  def validate
    validates_presence :title, allow_nil: false
    validates_presence :url, allow_nil: false
    validates_presence :created_at, allow_nil: false
  end

  def upload!(uploader = ImageUploader.new)
    file[:filename] = image_name(file[:filename])
    couldnt_save(file) unless uploader.store!(file)
    @values[:title] = title
    @url = @values[:url] = uploader.url
    @created_at = @values[:created_at] = DateTime.now
    save
  end

  private

  def couldnt_save(file)
    raise(InvalidFileError, "File: #{file}; could not be saved")
  end

  def accepted_extentions
    /.(jpg|jpeg|gif|png)/
  end

  def image_name(current_name)
    extention = current_name.match(accepted_extentions) || raise_invalid_filename(current_name)
    title     = @title.downcase.gsub(' ', '-')
    title + extention[0]
  end

  def raise_invalid_filename(name)
    raise(InvalidFileNameError, "#{ name } is not a valid file , must be one of: #{ accepted_extentions }")
  end

  class InvalidFileError     < StandardError; end
  class InvalidFileNameError < StandardError; end
end
