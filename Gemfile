source 'https://rubygems.org'

ruby '2.0.0'

# Server requirements
gem 'thin', '~> 1.6.2'

# Optional JSON codec (faster performance)
gem 'oj', '~> 2.10.2'

# Project requirements
gem 'rake',        '~> 10.3.2'
gem 'fog',         '~> 1.23.0', require: "fog/aws/storage"
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 3.8.0'

# Component requirements
gem 'bcrypt'
gem 'rack-coffee',   '~> 1.0.3', :require => 'rack/coffee'
gem 'coffee-script', '~> 2.3.0'
gem 'sass',          '~> 3.4.1'
gem 'haml',          '~> 4.0.5'
gem 'pg',            '~> 0.17.1'
gem 'sequel',        '~> 4.13.0'

# Test requirements
group :test do
  gem 'rr',          '~> 1.1.2', :require => false
  gem 'rspec',       '~> 3.0.0'
  gem 'rack-test',   '~> 0.6.2', :require => 'rack/test'
  gem 'capybara',    '~> 2.4.1'
  gem 'launchy',     '~> 2.4.2'
  gem 'poltergeist', '~> 1.5.1'
  gem 'rspec_sequel_matchers', '~> 0.4.0'
end

# Development helper gems
group :test, :development do
  gem 'debugger', '~> 1.6.8'
  gem 'dotenv',   '~> 0.11.1'
end

# Padrino Stable Gem
gem 'padrino', '~> 0.12.3'
