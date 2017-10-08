# テンプレートエンジン
gem 'slim-rails'

# css_normalize
gem 'normalize-rails'

# 環境変数
gem 'dotenv-rails'

# 認証
gem 'devise'
#gem 'authlogic'

# 認可
# gem 'pundit

# 非同期処理
# gem 'sidekiq'

gem_group :development do
  gem 'pry-byebug' # binding.pry
  gem 'pry-doc' # ドキュメント表示
  gem 'bullet' # N+1対策
  gem 'ruby-debug-ide' #エディタ用
  gem 'debase' #エディタ用
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rubocop', require: false # コーディング規約
end

run "rm README.rdoc"
run 'bundle install --path vendor/bundle --jobs=4'
