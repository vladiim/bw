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

  describe '#save' do
    context 'image params saved', focus: true do
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