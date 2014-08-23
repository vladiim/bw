require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe 'admin login' do
  context 'not admin' do
    it 'redirects me to login' do
      visit '/admin'
      expect(path(current_url)).to eq '/sessions/new'
    end
  end
end

# describe "the signup process" do
#   before :each do
#     User.make(:email => 'user@example.com', :password => 'caplin')
#   end

#   it "signs me in" do
#     visit '/sessions/new'
#     within("#session") do
#       fill_in 'Login', :with => 'user@example.com'
#       fill_in 'Password', :with => 'password'
#     end
#     click_link 'Sign in'
#     page.should have_content 'Success'
#   end
# end