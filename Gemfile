source 'https://rubygems.org'

ruby '~> 2.3.0'

gem 'active_model_serializers'
gem 'attr_defaultable', require: 'extend_attr_defaultable'
gem 'pg', '~> 0.18.4'
gem 'puma'
gem 'rack-cors'
gem 'rails', '4.2.6'
gem 'rails-api'
gem 'swagger-docs'
gem 'twilio-ruby'

group :development, :test do
  gem 'active_cucumber'
  gem 'byebug'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'dotenv'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'hashdiff'
  gem 'mortadella'
  gem 'rack-test'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'shoulda', '~> 3.5.0'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'simplecov-html'
end

group :test do
  gem "database_cleaner"
  gem 'rspec-json_expectations'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'annotate'
  gem 'spring'
end
