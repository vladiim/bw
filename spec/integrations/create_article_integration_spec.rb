require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe 'create article', type: :feature do
  it 'can have an article with a photograph and photographer' do

    sign_in

    click_new_article

    add_content 'TITLE', 'BODY'

    # Add the image
    click_link 'Hero image'
    fill_in 'Title:', with: 'IMAGE'
    attach_file('Image file:', (Dir.pwd + '/spec/integrations/fixtures/imgres.jpg'))

    # Add the photographer
    click_link 'Photographer'
    fill_in 'article_photographer_first_name', with: 'FIRST NAME'
    fill_in 'article_photographer_last_name', with: 'LAST NAME'
    attach_file('Image file:', (Dir.pwd + '/spec/integrations/fixtures/imgres.jpg'))
    # somehow add an image
    fill_in 'article_photographer_website', with: 'www.website.com'
    fill_in 'article_photographer_bio', with: 'BIO'

    # Add the meta data
    click_link 'Meta data'
    fill_in 'article_meta_tags', with: 'TAG1 TAG2'
    fill_in 'article_author_first_name', with: 'FIRST NAME'
    fill_in 'article_author_last_name', with: 'LAST NAME'

    click_button 'Save'
    article = Article.last
    expect(article.title).to eq 'TITLE'
    expect(article.body).to eq 'BODY'
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

def click_new_article
  # Go to new article
  click_link 'Articles'
  click_link 'New'
end

def add_content(title, body)
  fill_in 'Title:', with: title
  fill_in 'Body:', with: body
end