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
    # created_at
    it { is_expected.to have_column :created_at, type: :datetime }
    it { is_expected.to validate_presence :created_at, allow_nil: false }
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
        expect(image.url).to eq 'UPLOADER URL'
      end

      it "saves the image's created_at date to the current time" do
        expect(image.values[:created_at].year).to  eq DateTime.now.year
        expect(image.values[:created_at].month).to eq DateTime.now.month
        expect(image.values[:created_at].day).to   eq DateTime.now.day
        expect(image.values[:created_at].hour).to  eq DateTime.now.hour
        expect(image.created_at.year).to  eq DateTime.now.year
        expect(image.created_at.month).to eq DateTime.now.month
        expect(image.created_at.day).to   eq DateTime.now.day
        expect(image.created_at.hour).to  eq DateTime.now.hour
      end

      it 'saves the image' do
        expect(image.upload!(mock)).to eq 'SAVE'
      end
    end

    context 'invalid file name' do
      let(:file) { {:filename=>'blah.INVALID', :type=>'image/jpeg', :name=>'image[file]', :tempfile=>Object.new, :head=>'Content-Disposition: form-data; name=\'image[file]\'; filename=\'blah.jpg\'\r\nContent-Type: image/jpeg\r\n'} }

      it 'raises an InvalidFileName exception' do
        expect { image.upload!(mock) }.to raise_error(Image::InvalidFileNameError)
      end
    end

    context 'invalid file' do
      let(:file) { invalid_file }

      it 'raises an InvalidFile exception' do
        expect { image.upload!(mock) }.to raise_error(Image::InvalidFileError)
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