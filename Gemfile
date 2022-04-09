source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "importmap-rails"
gem "stimulus-rails"
gem "bootsnap", require: false
gem "sassc-rails"

gem "net-ssh"

gem "haml-rails"
gem 'high_voltage', '~> 3.1'

gem "passenger", "6.0.13" , require: "phusion_passenger/rack_handler"
gem "io-wait" , "0.2.0"
gem "dnsimple"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "mina"
  gem 'guard-rails'
  gem 'guard-rspec'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
