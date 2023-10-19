source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
# ここから追加
gem 'enum_help'
gem 'dotenv-rails'
gem 'googleauth'
gem 'google_drive'
gem 'ransack'
gem 'bcrypt'
gem 'bootstrap'
gem 'kaminari'
gem 'bootstrap5-kaminari-views'
gem 'rexml'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-rails'
  gem 'faker'
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'launchy'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'webdrivers'
end