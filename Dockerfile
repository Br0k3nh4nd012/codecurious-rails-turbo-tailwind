FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

WORKDIR /codecurious
COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.3.21

RUN bundle check || bundle install 
EXPOSE 3000