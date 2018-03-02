# Rails5 dev environment boilerplate with docker for mac

1. ruby/bundler/rails install

Detail is [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

```
brew install rbenv ruby-build
rbenv install 2.5.0
rbenv global 2.5.0
rbenv rehash
gem install rails
```

2. execute rails new

rails version depend on your local rails version:(
so you install rails in your laptop.

```
rails new project_name --template=https://raw.githubusercontent.com/Islands5/rails_template_source/master/template.rb --database=postgresql --skip-coffee  --skip-test --skip-bundle  --skip-sprockets --skip-turbolinks
```

NOTE: if you wanna use monogdb, remove --database option

NOTE2: webpack install manually after rails new is end. because this is rails design.
https://github.com/rails/rails/pull/28929

3. build & run

```
$cd project_name
```

if you use remote_debugger for using IDEs, please exec this command.

```
$echo 'export ENABLE_REMOTE_DEBUG="1"' >> .env
```

when running server

```
$make server
```

when debugging in console or rails commands

```
$make console
```

Gemfile or Dockerfile changed

```
$make build
```

Enjoy your rails life!!

TODO
・template fetch by rails repos
  [https://github.com/rails/rails/blob/8dd76a7a6ff1bb7105beabb8f834ca54ab1e5fc2/railties/lib/rails/generators/rails/app/templates/config/databases/mysql.yml.tt]
  [https://github.com/rails/rails/blob/8dd76a7a6ff1bb7105beabb8f834ca54ab1e5fc2/railties/lib/rails/generators/rails/app/templates/config/databases/postgresql.yml.tt]

