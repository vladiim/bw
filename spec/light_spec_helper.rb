RACK_ENV = 'test' unless defined?(RACK_ENV)
# require 'rr'
require 'sequel'
require 'rspec_sequel_matchers'
# require 'rack/test'

Sequel.connect("postgres://localhost/bw_test")
# RACK_ENV=test rake sq:migrate

RSpec.configure do |conf|
  # conf.mock_with :rr
  conf.include RspecSequel::Matchers
  # conf.include Rack::Test::Methods
end