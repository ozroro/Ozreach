FROM ruby:2.6.5-alpine3.10
ARG SECRET_KEY_BASE="a71082db97ca8cad38d03483c3a46ee9a2c11023920296afbf272bb78eaa1591b3c3da6bb815854afbddac97cbfb2c1733c1d0a56ba797052f879d1ed51bafd4"

ARG RUNTIME_PACKAGES="bash file imagemagick libxml2 libxslt nodejs mariadb-connector-c-dev tzdata yarn vim"
ARG BUILD_PACKAGES="build-base libxml2-dev libxslt-dev" 
ARG ROOT="/myapp"

ENV LANG=C.UTF-8TZ=Asia/Tokyo \
    RAILS_ENV="production" \
    NODE_ENV="production"

WORKDIR ${ROOT}
COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-packages --no-cache ${BUILD_PACKAGES} && \
    bundle install -j$(getconf _NPROCESSORS_ONLN) --without test development && \
    apk del --purge build-packages

COPY . ${ROOT}

# RUN bundle exec rails assets:clobber
RUN SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec rails assets:precompile && \
    yarn cache clean && \
    rm -rf node_modules tmp/cache && \
    mkdir -p tmp/pids tmp/sockets

# ENV RAILS_SERVE_STATIC_FILES="true"
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb", "-E", "production"]