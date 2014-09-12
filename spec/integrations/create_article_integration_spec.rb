require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe 'create article', type: :feature do
  it 'can have an article with a photograph and photographer' do
    @image = Dir.pwd + '/spec/integrations/fixtures/imgres.jpg'

    sign_in
    new_article('TITLE', 'BODY')
    add_hero_image('IMAGE')
    add_photographer('FIRST NAME', 'SURNAME', 'photographer@email', 'www.website.com', 'BIO')

    click_button 'Save'

    # save_and_open_page
    # Add the meta data
    # click_link 'Meta data'
    # fill_in 'article_meta_tags', with: 'TAG1 TAG2'
    # fill_in 'article_author_first_name', with: 'FIRST NAME'
    # fill_in 'article_author_last_name', with: 'LAST NAME'

    # click_button 'Save'
    article = Article.last
    expect(article.title).to eq 'TITLE'
    # expect(article.body).to eq 'BODY'
    # expect(article.author_id).to eq @author.id

    # Expect all the values to be published
    # click_button 'Publish'
    # visit "/articles/#{ article.id }"
    # expect(page).to have_content 'TITLE'
    # expect(page).to have_content 'BODY'

    # Expect the photographer to have their own page too
    # visit photographer page
    # expect first name & last name
    # expect article in list
  end
end

def sign_in
  visit '/admin/sessions/new'
  fill_in 'Email',    with: 'vladiim@yahoo.com.au'
  fill_in 'Password', with: 'password'
  click_button 'Sign In'
end

def new_article(title, body)
  click_link 'Articles'
  click_link 'New'
  fill_in 'article_title', with: title
  fill_in 'article_body', with: body
end

def add_hero_image(title)
  # Add the image
  click_link 'Hero image'
  fill_in 'article_image_attributes_0_title', with: title
  attach_file('article_image_attributes_0_file', @image)
end

def add_photographer(name, surname, email, website, bio)
  click_link 'Photographer'
  fill_in 'article_photographer_attributes_name', with: name
  # fill_in 'article_photographer_surname', with: surname
  # attach_file('article_photographer_image', @image)
  # fill_in 'article_photographer_website', with: website
  # fill_in 'article_photographer_bio', with: bio
end