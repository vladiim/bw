require_relative '../light_spec_helper'
require_relative '../../models/photographer'

RSpec.describe Photographer do
  let(:photographer) { Photographer.new }

  describe '#initialize' do
    it 'creates an instance of an account' do
      expect(photographer.account).to be_a Account
    end

    it "sets the account's role as photographer" do
      expect(photographer.account.role).to eq 'photographer'
    end
  end

  describe '#name=' do
    before { photographer.name=('NAME') }

    it "sets the account's name" do
      expect(photographer.account.name).to eq 'NAME'
    end
  end

  describe '#save', focus: true do
    let(:super_proc) { ->{ photographer.values[:id] = 'ID' } }
    let(:result)     { photographer.save(super_proc) }

    before do
      expect(photographer.account).to receive(:save)
    end

    it 'saves the account' do
      result
    end

    it 'sets the account_id' do
      expect(photographer.account_id).to eq 'ACCOUNT ID'
    end

    # context 'with image' do
    #   let(:attrs)   { {"title"=>"", "body"=>"", "image_attributes"=>{"0"=>{"title"=>"IMAGE TITLE", "file"=>'IMAGE FILE'}}} }
    #   let(:article) { Article.new(attrs) }

    #   before do
    #     expect(article.image).to receive(:upload!)
    #     allow(article.hero_image).to receive(:save) { 'HERO IMAGE SAVED' }
    #   end

    #   it 'uploads the image' do
    #     result
    #   end

    #   it 'adds the image id to the hero image' do
    #     article.image.id = 'IMAGE ID'
    #     result
    #     expect(article.hero_image.image_id).to eq 'IMAGE ID'
    #   end

    #   it 'adds the article id to the hero image' do
    #     result
    #     expect(article.hero_image.article_id).to eq 'ARTICLE ID'
    #   end

    #   it 'saves the hero image' do
    #     expect(result).to eq 'HERO IMAGE SAVED'
    #   end
    # end

    # it 'saves the article returning the id' do
    #   expect(result).to eq 'ARTICLE ID'
    # end
  end
end

class Account;
  attr_accessor :name, :role

  def id
    'ACCOUNT ID'
  end
end