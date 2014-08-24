class Image < Sequel::Model

  def upload!(title, file)
    uploader = ImageUploader.new
    @title = title
    # rename file to datetime + title with underscores
    # @main = uploader.url
    # @thumb = uploader.thumb.url
    uploader.store!(file) # returns nil if bad
    uploader.url
  end

end
