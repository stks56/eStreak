FROM ruby:2.6.3-alpine3.10

ENV APP_ROOT /usr/src/eStreak
WORKDIR $APP_ROOT

RUN apk update && \
    apk add --no-cache \
    curl-dev \
    gcc \
    g++ \
    imagemagick6-dev \
    libxml2-dev \
    libc-dev \
    mariadb-dev \
    nodejs \
    make \
    tzdata \
    vim \
    yarn && \
    rm -rf /usr/local/bundle/cache/* \
    /usr/local/share/.cache/* \
    /var/cache/* \
    /tmp/* \
    /usr/lib/mysqld* \
    /usr/bin/mysql*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

COPY . $APP_ROOT

EXPOSE  3000

ENV RAILS_ENV production

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN rm -f tmp/pids/server.pid
CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]
