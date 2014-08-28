require_relative '../light_spec_helper'
require_relative '../../models/image'

RSpec.describe Image do
  let(:image)  { Image.new(params) }
  let(:mock)   { MockImageUploader.new }
  let(:file)   { 'IMAGE FILE' }
  let(:params) { { 'title'=>'IMAGE TITLE', 'file'=>file } }

  describe 'validations' do
    # title
    it { is_expected.to have_column :title, type: String }
    it { is_expected.to validate_presence :title, allow_nil: false }
    # url
    it { is_expected.to have_column :url, type: String }
    it { is_expected.to validate_presence :url, allow_nil: false }
    # photographer_id
    it { is_expected.to have_column :photographer_id, type: Integer }


    # created_at
    # it { is_expected.to have_column :created_at, type: DateTime }
  end

  describe '#initialize' do
    it 'sets up the image title and file' do
      expect(image.title).to eq 'IMAGE TITLE'
      expect(image.file).to  eq 'IMAGE FILE'
    end
  end

  describe '#upload!' do
    before { allow(image).to receive(:save) { 'SAVE' } }

    context 'valid file' do
      let(:file) { {:filename=>'blah.jpg', :type=>'image/jpeg', :name=>'image[file]', :tempfile=>Object.new, :head=>'Content-Disposition: form-data; name=\'image[file]\'; filename=\'blah.jpg\'\r\nContent-Type: image/jpeg\r\n'} }

      before { image.upload!(mock) }

      it "changes the file's name to the title" do
        expect(file.fetch(:filename)).to eq 'image-title.jpg'
      end

      it "saves the image's title" do
        expect(image.values[:title]).to eq 'IMAGE TITLE'
      end

      it "saves the image's url as the uploader's url" do
        expect(image.values[:url]).to eq 'UPLOADER URL'
      end

      it "saves the image's created_at date to the current time", focus: true do
        require 'debugger'; debugger
        expect(image.values[:created_at]).to be_within DateTime.now
      end

      it 'saves the image' do
        expect(image.upload!(mock)).to eq 'SAVE'
      end
    end

    context 'invalid file name' do
      let(:file) { {:filename=>'blah.INVALID', :type=>'image/jpeg', :name=>'image[file]', :tempfile=>Object.new, :head=>'Content-Disposition: form-data; name=\'image[file]\'; filename=\'blah.jpg\'\r\nContent-Type: image/jpeg\r\n'} }

      it 'raises an InvalidFileName exception' do
        expect { image.upload!(mock) }.to raise_error(Image::InvalidFileName)
      end
    end

    context 'invalid file' do
      let(:file) { invalid_file }

      it 'raises an InvalidFile exception' do
        expect { image.upload!(mock) }.to raise_error(Image::InvalidFile)
      end
    end
  end
end

class MockImageUploader

  attr_reader :url
  def store!(file)
    return nil if file == invalid_file
    @url = 'UPLOADER URL'
  end
end

def invalid_file
  { :filename=>'image-title.jpeg', 'BAD FILE'=>nil }
end