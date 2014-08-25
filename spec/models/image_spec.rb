require 'spec_helper'

RSpec.describe Image do
  let(:image) { Image.new }
  let(:mock)  { MockImageUploader.new }
  let(:file)  { { :filename=>"images.jpg", :type=>"image/jpeg", :name=>"image[file]", :tempfile=>Object.new, :head=>"Content-Disposition: form-data; name=\"image[file]\"; filename=\"images.jpg\"\r\nContent-Type: image/jpeg\r\n" } }

  describe 'upload!' do
    before { image.upload! 'TITLE', file, mock }

    it "sets it's title to the title" do
      expect(image.title).to eq 'TITLE'
    end

    context 'valid file' do
      it "saves it's url as the uploader's url" do
        expect(image.url).to eq 'UPLOADER URL'
      end

      it "saves it's thumb_url as the uploader's thumb.url" do
        expect(image.thumb_url).to eq 'UPLOADER THUMB URL'
      end

      it "changes the file's name to the title" do
        image.upload! 'TITLE TEST', file, mock
        expect(file.fetch(:filename)).to eq 'title-test.jpg'
      end
    end

    context 'invalid file' do
      it 'raises an exception' do
        expect { image.upload! 'TITLE', {'BAD FILE'=>nil}, mock }.to raise_error
      end
    end
  end
end

class MockImageUploader

  attr_reader :url
  def store!(file)
    return nil if file == {'BAD FILE'=>nil}
    @url = 'UPLOADER URL'
  end

  def thumb_url
    'UPLOADER THUMB URL'
  end
end

