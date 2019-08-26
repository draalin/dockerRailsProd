# README

# INFRASTRUCTURE

nginx->puma->rails->redis/postgres

# COMPLETE
- Base Rails App
- Postgres
- Nginx
- Redis
- Sidekiq

# TO DO
- Passenger (Remove Puma)
- Letsencrypt
- Useful App

# Steps

Copy `.env.sample to .env`

## Building/Running
```
docker-compose run app rake db:create RAILS_ENV=production && \
docker-compose run app rake db:migrate db:seed RAILS_ENV=production && \
docker-compose up -d
```
Open with browser: `http://localhost/`


## Tearing down

```
docker-compose down && \
docker rmi $(docker images |grep 'dockerrailsprod_app') -f
```

# Stuff so I don't forget

## Redis

redis-cli info stats

## Rails

### Testing Sidekiq

http://localhost/sidekiq

```
RAILS_ENV=production rails g sidekiq:worker Hard
```

app/workers/hard_worker.rb
```
class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    # do something
  end
end
```

```
rails console
HardWorker.perform_async('bob', 5)
rails restart
```
