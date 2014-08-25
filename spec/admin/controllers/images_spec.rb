# require 'spec_helper'

# RSpec.describe "ImagesController" do

#   describe "create" do

#     it "responds to json" do
#       require 'debugger'; debugger
#       post '/admin/sessions/create', { bypass: true }
#       post '/admin/images/create', correct_params.to_json, format: :json
#       # require 'debugger'; debugger
#       expect(last_response).to be_ok
#     end
#   end
# end

# def correct_params
#   #<Tempfile:/var/folders/yr/5b_22mj97jq8h0xwgj5zfkxw0000gn/T/RackMultipart20140824-7459-1ahid4w>
#   # "authenticity_token"=>"d2a4041122c0af5abfd2763b0744f003"
#   { "image"=>{"title"=>"", "file"=>{:filename=>"images.jpg", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>Object.new, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"images.jpg\"\r\nContent-Type: image/jpeg\r\n"}}, "upload"=>"Upload"}
# end