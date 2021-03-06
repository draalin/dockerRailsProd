FROM ruby:2.6.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm

RUN npm install yarn -g

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/app_name
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV='production'
ENV RACK_ENV='production'

RUN mkdir tmp
RUN mkdir tmp/pids

# Adding gems
RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --jobs 20 --retry 5 --without development test

# Adding project files
COPY . .

# Run bundles
RUN bundle exec rake assets:precompile
RUN bundle exec sidekiq -e production -d -L ./log/sidekiq.log 

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]