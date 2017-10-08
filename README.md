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

3. up!

```
cd project_name
echo "DEBUG_MODE=0" >> .env
docker-compose up
```

above all!

Enjoy your rails life!!
