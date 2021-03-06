# app_nameでプロジェクトの名前にアクセスできる
template_repo = "https://raw.githubusercontent.com/Islands5/rails_template_source/master"
template_mongo = "https://raw.githubusercontent.com/mongodb/mongoid/master/lib/rails/generators/mongoid/config/templates/mongoid.yml"

# gemファイルがあればdbのアダプタがわかる
database_adapter = case IO.read("Gemfile") 
                   when /^\s*gem ['"]pg['"]/
                     "postgresql"
                   when /^\s*gem ['"]mysql2['"]/
                     "mysql"
                   else
                     "mongodb"
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

if database_adapter == "mongodb"
  gem 'mongoid'
end

gem_group :development do
  gem 'pry'
  gem 'bullet'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
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
get "#{template_repo}/Dockerfile", 'Dockerfile'
get "#{template_repo}/.dockerignore", '.dockerignore'
get "#{template_repo}/.env.development", '.env'
if ["postgresql", "mysql"].include?(database_adapter)
  run 'rm config/database.yml'
  get "#{template_repo}/config/database_#{database_adapter}.yml", 'config/database.yml'
else
  get template_mongo, "config/mongoid.yml"
end
get "#{template_repo}/compose_files/docker-compose_#{database_adapter}.yml", 'docker-compose.yml'
get "#{template_repo}/README.md", 'README.md'

run 'touch Gemfile.lock'
run 'echo "> 1%" >> .browserslistrc'

# app_nameへ変更
gsub_file "Dockerfile", /%app_name%/, app_name
if ["postgresql", "mysql"].include?(database_adapter)
  gsub_file "config/database.yml", /%app_name%/, app_name
else
  gsub_file "config/mongoid.yml", /\<%=\sdatabase_name.*?%\>/, app_name
  gsub_file "config/mongoid.yml", /localhost/, "db"
end
gsub_file "docker-compose.yml", /%app_name%/, app_name

# redisの設定
comment_lines "config/environments/development.rb", "config.cache_store"
comment_lines "config/environments/test.rb", "config.cache_store"


environment(nil, env: "development") do
 "config.cache_store = :redis_store, 'redis://redis/0/cache'"
end

environment(nil, env: "test") do
 "config.cache_store = :redis_store, 'redis://redis/0/cache'"
end

environment("config.generators.helper = false", env: nil)
environment("config.generators.stylesheets = false", env: nil)
environment("config.generators.javascripts = false", env: nil)
environment("config.generators.channel = {assets: false}", env: nil)
