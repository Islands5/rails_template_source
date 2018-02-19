# app_nameでプロジェクトの名前にアクセスできる
template_repo = "https://raw.githubusercontent.com/Islands5/rails_template_source/master"

# gemファイルがあればdbのアダプタがわかる
database_adapter = case IO.read("Gemfile") 
                   when /^\s*gem ['"]pg['"]/
                     "postgresql"
                   when /^\s*gem ['"]mysql2['"]/
                     "mysql"
                   else
                     "sqlite"
                   end

# テンプレートエンジン
gem 'slim-rails'
# font-awesome
gem 'font-awesome-rails'
# 環境変数
gem 'dotenv-rails'
# 認証
gem 'devise'
# 認可
#gem 'pundit
# middleware
gem 'redis-rails'
# 非同期処理
gem 'sidekiq'

gem_group :development do
  gem 'pry'
  gem 'bullet' # N+1対策
  # require: falseが必要なのはpry系とruby-debug-ideがケンカするから2018/2/19
  gem 'pry-rails', require: false
  gem 'pry-byebug', require: false
  gem 'pry-doc', require: false
  gem 'ruby-debug-ide', '0.6.1.beta12',  require: false
  gem 'debase', 'v0.2.2.beta14',  require: false
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rubocop', require: false # コーディング規約
end

run 'rm README.rdoc'
run 'gibo Rails >> .gitignore' # giboを入れましょう! あとgibo -uで最新のignoreに更新されます
run 'gibo JetBrains >> .gitignore'
run 'gibo macOS >> .gitignore'
run 'gibo node >> .gitignore' 

# 設定ファイルを色々取ってくる
get "#{template_repo}/docker-compose_#{database_adapter}.yml", 'docker-compose.yml'
get "#{template_repo}/Dockerfile", 'Dockerfile'
get "#{template_repo}/.dockerignore", '.dockerignore'
get "#{template_repo}/config/database_#{database_adapter}.yml", 'config/database.yml'
get "#{template_repo}/.env.development", '.env'

run 'touch Gemfile.lock'

# app_nameへ変更
gsub_file "docker-compose.yml", /%app_name%/, app_name
gsub_file "Dockerfile", /%app_name%/, app_name
gsub_file "config/database.yml", /%app_name%/, app_name

# redisの設定
comment_lines "config/environments/development.rb", "config.cache_store"
comment_lines "config/environments/test.rb", "config.cache_store"


application(nil, env: "development") do
 "config.cache_store = :redis_store, 'redis://redis/0/cache'"
end
application(nil, env: "test") do
 "config.cache_store = :redis_store, 'redis://redis/0/cache'"
end
