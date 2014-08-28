class Image < Sequel::Model

  attr_accessor :title, :file, :url, :created_at

  plugin :validation_helpers

  def validate
    validates_presence :title, allow_nil: false
    validates_presence :url, allow_nil: false
  end

  def upload!(uploader = ImageUploader.new)
    file[:filename] = image_name(file[:filename])
    couldnt_save(file) unless uploader.store!(file)
    self.values[:title] = title
    self.values[:url] = uploader.url
    self.values[:created_at] = DateTime.now
    save
  end

  private

  def couldnt_save(file)
    raise(InvalidFile, "File: #{file}; could not be saved")
  end

  def image_name(current_name)
    match     = /.(jpg|jpeg|gif|png)/
    extention = current_name.match(match) || raise_invalid_filename(current_name, match)
    title     = @title.downcase.gsub(' ', '-')
    title + extention[0]
  end

  def raise_invalid_filename(name, accepted_extentions)
    raise(InvalidFileName, "#{ name } is not a valid file , must be one of: #{ accepted_extentions }")
  end

  class InvalidFile     < StandardError; end
  class InvalidFileName < StandardError; end
end
