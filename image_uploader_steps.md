.env file & set up

# 1. gemfile

gem "fog", require: "fog/aws/storage"
gem "carrierwave"

***

# 2. initializer

# confit/boot

require 'fog/aws/storage'
require 'carrierwave'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.fog_directory  = 'blackwhite'
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end

***

# 3. class

padrino g model Image title:string file:text file_name:string photographer_id:integer

class Image
  def save
    uploader = ImageUploader.new
    uploader.store! file
  end
end

padrino g model ImageUploader -s

class ImageUploader < CarrierWave::Uploader::Base
  storage :fog
end

***

# 4. controller

padrino g controller Image post:create

***

# 5. View

= form_for :image, url(:images, :create), :method=>"post", :enctype=>"multipart/form-data" do |f|
  / =partial 'articles/form', :locals => { :f => f }

  %fieldset.control-group
    = f.label :title, :class => 'control-label'
    .controls
      = f.text_field :title

  %fieldset.control-group
    =f.label :file, :class => 'control-label'
    .controls
      = f.file_field :file

  =f.submit :upload, :class => 'btn btn-info', :name => 'upload', value: 'Upload'

***

params in controller

{"authenticity_token"=>"21ed25ae9ac386da2dd3bb54e8cf9a48", "image"=>{"title"=>"", "file"=>{:filename=>"imgres.jpg", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>#<Tempfile:/var/folders/yr/5b_22mj97jq8h0xwgj5zfkxw0000gn/T/RackMultipart20140824-7053-6m8y26>, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"imgres.jpg\"\r\nContent-Type: image/jpeg\r\n"}}, "upload"=>"Upload"}