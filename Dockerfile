# Multi-stage Dockerfile: build gems in a builder image, produce small runtime image
FROM ruby:3.2.3-alpine AS builder
RUN apk add --no-cache build-base libffi-dev bash

WORKDIR /app
COPY Gemfile Gemfile.lock ./

# Install bundler, configure local path for gems, then install
RUN gem install bundler \
 && bundle config set --local path '/app/vendor/bundle' \
 && bundle install --jobs 4 --retry 3

FROM ruby:3.2.3-alpine
RUN apk add --no-cache libstdc++ libffi

# Create a non-root user
RUN addgroup -S app && adduser -S -G app app
WORKDIR /app

# Copy installed gems from builder
COPY --from=builder /app/vendor /app/vendor

# Ensure Ruby/Bundler use the copied gems at runtime
ENV GEM_HOME=/app/vendor/bundle
ENV BUNDLE_PATH=/app/vendor/bundle
ENV PATH=/app/vendor/bundle/ruby/3.2.0/bin:/app/vendor/bundle/bin:$PATH

# Copy application files
COPY . .

# Run as non-root
USER app

EXPOSE 4567
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
