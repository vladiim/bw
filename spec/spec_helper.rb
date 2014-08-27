# RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "light_spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
# require 'rr'
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  # conf.mock_with :rr
  # conf.include RspecSequel::Matchers
  conf.include Rack::Test::Methods
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Blackwhitesprint::App
#   app Blackwhitesprint::App.tap { |a| }
#   app(Blackwhitesprint::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

def uri_path(uri)
  URI.parse(uri).path
end