FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client


COPY Gemfile Gemfile.lock ./
ENV RAILS_ROOT /var/www/codecurious
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV RAILS_ENV='production'
ENV RACK_ENV='production'

RUN gem install bundler -v 2.3.21

RUN bundle check || bundle install --without development test

COPY . .
# RUN bundle exec rake secret   
# RUN EDITOR="mate --wait" bin/rails credentials:edit
RUN bundle exec rake assets:precompile  
# RUN bundle exec bin/rails tailwindcss:build
EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]