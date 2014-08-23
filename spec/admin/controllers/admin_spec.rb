require 'spec_helper'

RSpec.describe "AdminController" do
  before { get "/admin" }

  context 'logged out' do
    it "redirects to a login page" do
      expect(last_response).to be_redirection
      expect(uri_path(last_response.location)).to eq '/admin/sessions/new'
    end
  end
end