# Rails5 dev environment boilerplate with docker for mac

## How It Works

### Need setup your laptop

Detail is [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

```
$ brew install rbenv ruby-build
$ rbenv install 2.5.0
$ rbenv global 2.5.0
$ rbenv rehash
$ gem install rails
#=> the rails version is same boilerplate one
```

### Rails new

```
$ rails new project_name --template=https://raw.githubusercontent.com/Islands5/rails_template_source/master/template.rb --database=postgresql --skip-coffee  --skip-test --skip-bundle  --skip-sprockets --skip-turbolinks

$ cd project_name
```

NOTE: if you wanna use monogdb, remove --database option

NOTE2: webpack install manually after rails new is end. because this is rails design.
https://github.com/rails/rails/pull/28929

### Frontend

I inspired by [this article](https://evilmartians.com/chronicles/evil-front-part-1)
If you don't use webpacker, delete webpcker in Gemfile and skip this section :)
TODO comments!!

```
$ make server #=> open another terminal
$ make console
# bin/rails webpacker:install
# mv app/javascript frontend
```

javascript_include_tag, stylesheet_include_tag => s/include/pack/ in application.html.erb
and move hoge_pack_tag to <body></body>. before yield.

edit config/webpacker.yml

```
default: &default
  source_path: frontend
  source_entry_path: packs
  public_output_path: packs
  cache_path: tmp/cache/webpacker
```



### container control

I set Makefile to use docker easily.

```
$ make build              docker-compose build
$ make server             docker-compose run --rm --name project_name_rails_1 -p 3000:3000 rails
$ make console            docker exec -it project_name_rails_1 /bin/bash
$ make dbconsole          docker exec -it project_name_db_1 /bin/bash
$ make redisconsole       docker exec -it project_name_redis_1 /bin/bash
$ make delete             docker conrainer rm project_name_rails_1
$ make help               show help
```

"bundle install" or docker settings is changed.
```
$ make build
```

"rails s" or before "rails console"
Rails container start.
```
$ make server
```

"rails console" or rails(rake) tasks e.g. "bin/rails db:migrate", "bin/rails webpacker:install"
```
$ make console
```

etc.

get into an service container. please watch docker-compose.yml
```
$ make dbconsole/redisconsole
```

if you get the error "Conflict. The container name "/project_name_rails_1" is already in use by container"
kill rails container :)
```
$ make delete
```
