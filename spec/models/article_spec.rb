require_relative '../light_spec_helper'
require_relative '../../models/article'

RSpec.describe Article do
  let(:article) { Article.new }

  describe '#initialize' do

    context 'with image attrs' do
      let(:attrs)   { { "title"=>"", "body"=>"", "image_attributes"=>{ "0"=>{ "title"=>"IMAGE TITLE", "file"=>'IMAGE FILE' } } } }
      let(:article) { Article.new(attrs) }

      it 'sets up the image' do
        expect(article.image.title).to eq 'IMAGE TITLE'
        expect(article.image.file).to eq 'IMAGE FILE'
      end
    end
  end

  describe '#save' do
    let(:super_proc) { ->{ article.values[:id] = 'ARTICLE ID' } }
    let(:result)     { article.save(super_proc) }

    context 'with image' do
      let(:attrs)   { {"title"=>"", "body"=>"", "image_attributes"=>{"0"=>{"title"=>"IMAGE TITLE", "file"=>'IMAGE FILE'}}} }
      let(:article) { Article.new(attrs) }

      before do
        expect(article.image).to receive(:upload!)
        allow(article.hero_image).to receive(:save) { 'HERO IMAGE SAVED' }
      end

      it 'uploads the image' do
        result
      end

      it 'adds the image id to the hero image' do
        article.image.id = 'IMAGE ID'
        result
        expect(article.hero_image.image_id).to eq 'IMAGE ID'
      end

      it 'adds the article id to the hero image' do
        result
        expect(article.hero_image.article_id).to eq 'ARTICLE ID'
      end

      it 'saves the hero image' do
        expect(result).to eq 'HERO IMAGE SAVED'
      end
    end

    it 'saves the article returning the id' do
      expect(result).to eq 'ARTICLE ID'
    end
  end

  describe '.find' do
    let(:result)  { Article.find(1) }
    let(:dataset) { Object.new }

    before do
      allow(Article).to receive(:[]).with(1) { article }
      allow(article).to receive(:image_dataset) { dataset }
    end

    context 'saved hero image' do
      let(:image) { Object.new }
      before { allow(dataset).to receive(:first) { image } }

      it 'returns the article' do
        expect(result).to eq article
      end

      it 'finds its hero image' do
        result
        expect(article.saved_hero_image).to eq image
      end
    end

    context 'no saved hero image' do
      before { allow(dataset).to receive(:first) { nil } }

      it 'returns a null hero image' do
        result
        expect(article.saved_hero_image).to be_a NullHeroImage
      end
    end
  end

  describe 'hero_image methods', focus: true do
    context 'not saved' do
      it 'returns nothing' do
        expect(article.hero_image_title).to eq ''
        expect(article.hero_image_url).to eq ''
      end
    end

    context 'with hero image' do
      let(:saved_hero_image) { OpenStruct.new({ values: { title: 'HERO TITLE', url: 'HERO URL' } }) }
      before { article.saved_hero_image = saved_hero_image }

      it "returns the hero image's value" do
        expect(article.hero_image_title).to eq 'HERO TITLE'
        expect(article.hero_image_url).to eq 'HERO URL'
      end
    end

    context 'with null hero image' do
      require_relative '../../models/null_hero_image'
      before { article.saved_hero_image = NullHeroImage.new }

      it 'returns nothing' do
        expect(article.hero_image_title).to eq ''
        expect(article.hero_image_url).to eq ''
      end
    end
  end
end

class NullHeroImage; end

class Image < Sequel::Model
  attr_accessor :file
  def upload!; end
end

class HeroImage
  attr_accessor :image_id, :article_id
  def save; end
end