FROM chatwoot/chatwoot:v2.18.0-ce

ARG FRONTEND_URL ACTIVE_STORAGE_SERVICE DATABASE_URL DEFAULT_LOCALE INSTALLATION_ENV NODE_ENV RAILS_ENV REDIS_URL SECRET_KEY_BASE

RUN apk add --no-cache multirun

RUN sleep 3 && bundle exec rails db:chatwoot_prepare && bundle exec rails db:migrate

ENTRYPOINT ["multirun"]

CMD ["bundle exec sidekiq -C config/sidekiq.yml", "bundle exec rails s -b 0.0.0.0 -p $PORT"]