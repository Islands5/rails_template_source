# app_nameでプロジェクトの名前にアクセスできる
template_repo = "https://raw.githubusercontent.com/Islands5/rails_template_source/master"

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

# middleware
gem 'redis-rails'

# 非同期処理
# gem 'sidekiq'

gem_group :development do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'bullet' # N+1対策
  gem 'ruby-debug-ide' #エディタ用
  gem 'debase' #エディタ用
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rubocop', require: false # コーディング規約
end

run 'rm README.rdoc'
run 'rm config/database.yml'
run 'mkdir .vscode'
run 'gibo rails >> .gitignore' # giboを入れましょう! あとgibo -uで最新のignoreに更新されます
run 'bundle install --path vendor/bundle --jobs=4'

# 設定ファイルを色々取ってくる
get "#{template_repo}/docker-compose.yml", 'docker-compose.yml'
get "#{template_repo}/Dockerfile", 'Dockerfile'
get "#{template_repo}/.dockerignore", '.dockerignore'
get "#{template_repo}/config/database.yml", 'config/database.yml'
get "#{template_repo}/.vscode/launch.json", '.vscode/launch.json'

# app_nameへ変更
gsub_file "docker-compose.yml", /%app_name%/, app_name
gsub_file "Dockerfile", /%app_name%/, app_name
gsub_file "config/database.yml", /%app_name%/, app_name
gsub_file ".vscode/launch.json", /%app_name%/, app_name

# redisの設定
comment_lines "config/environments/development.rb", "config.cache_store"
comment_lines "config/environments/test.rb", "config.cache_store"

application(nil, env: "development") do
 "config.cache_store = :redis_store, 'redis://kvs/0/cache'"
end
application(nil, env: "test") do
 "config.cache_store = :redis_store, 'redis://kvs/0/cache'"
end
