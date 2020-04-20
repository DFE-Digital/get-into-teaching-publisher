FROM ruby:2.7.1-alpine
RUN apk add --no-cache git

RUN mkdir /app
WORKDIR /app
ENV BUNDLE_PATH /gems

COPY Gemfile* /app/
RUN bundle

ARG UI_REPO=https://github.com/DFE-Digital/get-into-teaching-ui.git
ARG UI_BRANCH=master

COPY . .
RUN git clone --depth=1 --branch=$UI_BRANCH $UI_REPO ui
RUN mv ui/assets content && mv ui/layouts/* layouts && mv ui/helpers lib/helpers
RUN bundle exec nanoc compile
