FROM ruby:2.7.1-alpine AS build

RUN mkdir /app
WORKDIR /app
ENV BUNDLE_PATH /gems

COPY Gemfile* /app/
RUN bundle

COPY . .
RUN bundle exec nanoc compile

FROM nginx:stable-alpine
ENV PORT=80
COPY docker-run.sh /
CMD ['/docker-run.sh']
COPY --from=build /app/output/ /usr/share/nginx/html/
