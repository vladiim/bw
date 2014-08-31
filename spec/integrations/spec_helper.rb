require 'capybara/rspec'
require 'capybara/poltergeist'
RACK_ENV='test'
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

Capybara.app = Padrino.application
Capybara.javascript_driver = :poltergeist