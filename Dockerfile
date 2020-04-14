FROM ruby:2.7.1-alpine

RUN mkdir /app
WORKDIR /app
ENV BUNDLE_PATH /gems

COPY Gemfile* /app/
RUN bundle

COPY . .
RUN bundle exec nanoc compile
