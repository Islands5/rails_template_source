# view
gem 'slim-rails'
gem 'sass-rails'

# env
gem 'dotenv-rails'

gem 'devise'
# gem 'authlogic'

# gem 'pundit

# gem 'redis'
# gem 'sidekiq'

gem_group :development do
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'bullet'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rubocop', require: false
end

run "rm README.rdoc"
run 'bundle install --path vendor/bundle --jobs=4'
