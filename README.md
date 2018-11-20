# Rails5 dev environment boilerplate with docker for mac

## How It Works

### Need setup your laptop

Detail is [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

```
$ brew install rbenv ruby-build gibo
$ rbenv install 2.5.3
$ rbenv global 2.5.3
$ rbenv rehash
$ gem install rails
#=> the rails version is same boilerplate one
```

### Rails new

```
$ rails new project_name --template="https://raw.githubusercontent.com/Islands5/rails_template_source/master/template.rb" --database=postgresql -S -J -T --skip-bundle —-skip-turbolinks

$ cd project_name
```

NOTE: if you wanna use monogdb, remove --database option

### Frontend

vanila webpack :)

```
```
