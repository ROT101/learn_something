# Multi-stage Dockerfile: build gems in a builder image, produce small runtime image
FROM ruby:3.2-alpine AS builder
RUN apk add --no-cache build-base libffi-dev bash

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 3 --path vendor/bundle

FROM ruby:3.2-alpine
RUN apk add --no-cache libstdc++ libffi

# Create a non-root user
RUN addgroup -S app && adduser -S -G app app
WORKDIR /app

# Copy installed gems from builder
COPY --from=builder /app/vendor /app/vendor
ENV GEM_HOME=/app/vendor
ENV BUNDLE_PATH=/app/vendor

COPY . .

# Ensure puma runs as non-root
USER app

EXPOSE 4567
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
