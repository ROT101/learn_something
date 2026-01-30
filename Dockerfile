# Multi-stage Dockerfile: build gems in a builder image, produce small runtime image
FROM ruby:3.2-alpine AS builder
RUN apk add --no-cache build-base libffi-dev bash git

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

FROM ruby:3.2-alpine
RUN apk add --no-cache libstdc++ libffi

# Create a non-root user
RUN addgroup -S app && adduser -S -G app app
WORKDIR /app

# Copy installed gems from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

# Copy application code
COPY . .

# Ensure proper permissions
RUN chown -R app:app /app

# Ensure puma runs as non-root
USER app

EXPOSE 4567
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
