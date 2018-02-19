# Rails5 dev environment boilerplate with docker for mac

1. ruby/bundler/rails install

Detail is [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

```
brew install rbenv ruby-build
rbenv install 2.4.0
rbenv global 2.4.0
rbenv rehash
gem install rails
```

2. execute rails new

```
rails new project_name --template=https://raw.githubusercontent.com/Islands5/rails_template_source/master/template.rb --database=postgresql --skip-coffee  --skip-test --skip-bundle
```

3. build & run

```
$cd project_name

- if you use remote_debugger for using IDEs, please exec this command.
$echo 'export ENABLE_REMOTE_DEBUG="1"' >> .env
-


$docker-compose build
$docker-compose run --rm --name project_name_rails_1 -p 3000:3000 rails
```

Enjoy your rails life!!

TODO
・template fetch by rails repos
  [https://github.com/rails/rails/blob/8dd76a7a6ff1bb7105beabb8f834ca54ab1e5fc2/railties/lib/rails/generators/rails/app/templates/config/databases/mysql.yml.tt]
  [https://github.com/rails/rails/blob/8dd76a7a6ff1bb7105beabb8f834ca54ab1e5fc2/railties/lib/rails/generators/rails/app/templates/config/databases/postgresql.yml.tt]
