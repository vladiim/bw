class Image < Sequel::Model

  attr_accessor :title, :url, :thumb_url
  def upload!(title, file, uploader = ImageUploader.new)
    @title = title
    file[:filename] = image_name(file[:filename])
    couldnt_save(file) unless uploader.store!(file)
    @url = uploader.url
  end

  private
  def couldnt_save(file)
    raise "File: #{file}; could not be saved"
  end

  def image_name(current_name)
    title = @title.downcase.gsub(' ', '-')
    title + current_name.match(/.(jpg|jpeg|gif|png)/)[0]
  end
end
