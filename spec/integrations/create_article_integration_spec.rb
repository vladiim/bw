require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe 'create article', type: :feature do
  it 'can have an article with a photograph and photographer' do
    # Sign in
    visit '/admin/sessions/new'
    check 'Bypass login?'
    click_button 'Sign In'

    # Go to new article
    click_link 'Articles'
    click_link 'New'

    # Add the content
    fill_in 'Title:', with: 'TITLE'
    fill_in 'Body:', with: 'BODY'

    # Add the image
    click_link 'Hero image'
    fill_in 'Title:', with: 'IMAGE'
    click_button 'Add image'
    # somehow add an image

    # Add the photographer
    click_link 'Photographer'
    fill_in 'First name:', with: 'FIRST NAME'
    fill_in 'Last name:', with: 'LAST NAME'
    click_button 'Add image'
    # somehow add an image
    fill_in 'Website:', with: 'www.website.com'
    fill_in 'Bio:', with: 'BIO'

    # Add the meta data
    fill_in 'Tags:', with: 'TAG1 TAG2'

    # Expect all the values to be saved
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
  end
end