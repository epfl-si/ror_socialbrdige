FROM ruby:2.4-alpine3.7

# RUN apk add --update ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev

RUN apk add --update ruby-dev build-base libxml2-dev libxslt-dev sqlite-dev nodejs

RUN mkdir /app_local
WORKDIR /app_local
COPY Gemfile /app_local/Gemfile
COPY Gemfile.lock /app_local/Gemfile.lock
RUN bundle install

# RUN gem install nokogiri -- --use-system-libraries
# RUN gem install nio4r
# RUN gem install websocket-driver -v '0.6.5'
# RUN gem install bcrypt -v '3.1.11' 
# RUN gem install bindex -v '0.5.0'
# RUN gem install ffi -v '1.9.23'
# RUN gem install byebug -v '10.0.1'
# RUN gem install json -v '2.1.0'
# RUN gem install puma -v '3.11.3'
# RUN apk add --update sqlite-dev
# RUN gem install sqlite3 -v '1.3.13'
# RUN apk add --update nodejs

RUN apk del ruby-dev build-base

