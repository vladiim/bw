require_relative '../light_spec_helper'
require_relative '../../models/article'

RSpec.describe Article do
  let(:article) { Article.new }

  describe '#initialize' do
    it 'instantiates an image' do
      expect(article.image).to be_a Image
    end

    it 'instantiates a hero image' do
      expect(article.hero_image).to be_a HeroImage
    end
  end

  describe '#image_title=' do
    it 'saves the value to the passed in image' do
      article.image_title=('TITLE')
      expect(article.image.title).to eq 'TITLE'
    end
  end

  describe '#image_file=' do
    it 'saves the value to the passed in image' do
      article.image_file=('FILE')
      expect(article.image.file).to eq 'FILE'
    end
  end

  context 'saved article' do
    describe '.find' do
      let(:article)          { Article.find(1) }
      let(:saved_article)    { OpenStruct.new }
      let(:saved_hero_image) { OpenStruct.new }
      let(:saved_image)      { OpenStruct.new }

      before do
        allow(Article).to receive(:[]).with(1) { saved_article }
        saved_article.id = 2
        allow(HeroImage).to receive(:first).with({ article_id: 2 }) { saved_hero_image }
        saved_hero_image.image_id = 3
        allow(Image).to receive(:[]).with(3) { saved_image }
      end

      it 'finds the article' do
        expect(article).to eq saved_article
      end

      it 'finds and sets the saved_hero_image' do
        expect(article.saved_hero_image).to eq saved_hero_image
      end

      it 'finds and sets the saved_image' do
        expect(article.saved_image).to eq saved_image
      end
    end
  end

  describe '#image_url' do
    context 'with saved_image' do
      before { article.saved_image = OpenStruct.new(values: { url: 'IMAGE URL' }) }

      it "returns the image's url" do
        expect(article.image_url).to eq 'IMAGE URL'
      end
    end

    context 'without saved_image' do
      it 'returns an empty string' do
        expect(article.image_url).to eq ''
      end
    end
  end

  describe '#image_title' do
    context 'with saved_image' do
      before { article.saved_image = OpenStruct.new(values: { title: 'IMAGE TITLE' }) }

      it "returns the image's title" do
        expect(article.image_title).to eq 'IMAGE TITLE'
      end
    end

    context 'without saved_image' do
      it 'returns an empty string' do
        expect(article.image_title).to eq ''
      end
    end
  end

  describe '#save' do
    context 'image params saved' do
      let(:super_proc) { ->{ article.values[:id] = 'ARTICLE ID' } }
      let(:result)     { article.save(super_proc) }

      before do
        article.image_title = 'TITLE'
        article.image_file  = 'FILE'
        expect(article.image).to receive(:upload!)
        allow(article.image).to  receive(:id) { 'IMAGE ID'}
        result
      end

      it 'saves the uploaded image id to the hero image' do
        expect(article.hero_image.image_id).to eq 'IMAGE ID'
      end

      it 'saves the article id to the hero image' do
        expect(article.hero_image.article_id).to eq 'ARTICLE ID'
      end

      it 'saves the hero image' do
        expect(article.hero_image.saved).to eq true
      end
    end
  end
end

class Image < OpenStruct; end

class HeroImage < OpenStruct
  attr_reader :saved
  def save
    @saved = true
  end
end