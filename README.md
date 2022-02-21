# Refactoring exercise for trainees

## Dependencies

`Ruby ~> 2.7`
`Bundler ~> 2.3`

## Setup

```
$ bundle install
$ cp config/database.yml.example config/database.yml
$ rails db:create db:migrate
```

## Running locally

```
$ bundle exec rspec
```