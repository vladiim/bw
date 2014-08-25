require 'spec_helper'

RSpec.describe Image do
  let(:image) { Image.new(params) }
  let(:mock)  { MockImageUploader.new }
  # let(:file)  { { :filename=>"images.jpg", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>Object.new, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"images.jpg\"\r\nContent-Type: image/jpeg\r\n" } }
  let(:file)   { 'IMAGE FILE' }
  let(:params) { {"title"=>"IMAGE TITLE", "file"=>file} }

  describe '#initialize' do
    it 'sets up the image title and file' do
      expect(image.title).to eq 'IMAGE TITLE'
      expect(image.file).to  eq 'IMAGE FILE'
    end
  end

  describe '#upload!' do
    before { image.upload!(mock) }

    context 'valid file' do
      let(:file) { {:filename=>"blah.jpg", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>Object.new, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"blah.jpg\"\r\nContent-Type: image/jpeg\r\n"} }

      it "changes the file's name to the title" do
        expect(file.fetch(:filename)).to eq 'image-title.jpg'
      end

      it "saves the image's url as the uploader's url" do
        expect(image.url).to eq 'UPLOADER URL'
      end
    end

    context 'invalid file name' do
      let(:file) { {:filename=>"blah.INVALID", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>Object.new, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"blah.jpg\"\r\nContent-Type: image/jpeg\r\n"} }
      # let(:file) { { 'BAD FILE'=>nil } }

      it 'raises an exception' do
        expect { image.upload!(mock) }.to raise_error InvalidFileName
      end
    end
  end

  # describe 'upload!' do
  #   before { image.upload! 'TITLE', file, mock }

  #   it "sets it's title to the title" do
  #     expect(image.title).to eq 'TITLE'
  #   end

  #   context 'valid file' do
  #     it "saves it's url as the uploader's url" do
  #       expect(image.url).to eq 'UPLOADER URL'
  #     end

  #     it "saves it's thumb_url as the uploader's thumb.url" do
  #       expect(image.thumb_url).to eq 'UPLOADER THUMB URL'
  #     end

  #     it "changes the file's name to the title" do
  #       image.upload! 'TITLE TEST', file, mock
  #       expect(file.fetch(:filename)).to eq 'title-test.jpg'
  #     end
  #   end

  #   context 'invalid file' do
  #     it 'raises an exception' do
  #       expect { image.upload! 'TITLE', {'BAD FILE'=>nil}, mock }.to raise_error
  #     end
  #   end
  # end
end

class MockImageUploader

  def url
    'UPLOADER URL'
  end

  # attr_reader :url
  # def store!(file)
  #   return nil if file == {'BAD FILE'=>nil}
  #   @url = 'UPLOADER URL'
  # end

end