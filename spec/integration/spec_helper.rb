require 'capybara'
require 'capybara/padrino/rspec'
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

require 'capybara/dsl'

Capybara.app = app

RSpec.configure do |config|
  config.include Capybara::DSL
end

def path(url)
  URI.parse(url).path
end