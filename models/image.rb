class Image < Sequel::Model

  attr_accessor :title, :file

  attr_accessor :url
  def upload!(uploader=ImageUploader.new)
    file[:filename] = image_name(file[:filename])
    @url = uploader.url
  end

  # attr_accessor :title, :url, :file
  # def upload!(title, file, uploader = ImageUploader.new)
  #   @title = title
  #   file[:filename] = image_name(file[:filename])
  #   couldnt_save(file) unless uploader.store!(file)
  #   @url = uploader.url
  #   save
  # end

  private
  # def couldnt_save(file)
  #   raise "File: #{file}; could not be saved"
  # end

  def image_name(current_name)
    title = @title.downcase.gsub(' ', '-')
    title + current_name.match(/.(jpg|jpeg|gif|png)/)[0]
  end
end
