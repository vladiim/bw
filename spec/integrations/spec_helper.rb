require 'capybara/rspec'
require 'capybara/poltergeist'
RACK_ENV='test'
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

Capybara.app = Padrino.application
Capybara.javascript_driver = :poltergeist

CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
end

# CarrierWave::Uploader::Base.descendants.each do |klass|
#   next if klass.anonymous?
#   klass.class_eval do
#     def cache_dir
#       "#{ Padrino.root }/spec/integrations/fixtures"
#     end

#     def store_dir
#       "#{ Padrino.root }/spec/integrations/fixtures/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#     end
#   end
# end

# RSpec.configure do |config|
#   config.after(:each) do
#     if Padrino.env == :test
#       FileUtils.rm(Dir["#{ Padrino.root }/spec/integrations/fixtures/**.jpg"])
#     end 
#   end
# end