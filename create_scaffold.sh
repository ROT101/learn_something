#!/usr/bin/env bash
set -euo pipefail

# Safety: check branch
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$BRANCH" != "scaffold/sinatra-puma-docker" ]; then
  echo "Error: you must run this script on branch scaffold/sinatra-puma-docker (current: $BRANCH)"
  exit 1
fi

# Create directories
mkdir -p deploy/nginx deploy/systemd .github/workflows

# Write files
cat > app.rb <<'RUBY'
# Simple Sinatra application
require 'sinatra'
require 'json'

get '/' do
  content_type :json
  { message: "Welcome to learn_something (ROT101)" }.to_json
end

get '/health' do
  status 200
  'OK'
end
RUBY

cat > Gemfile <<'RUBY'
source 'https://rubygems.org'
ruby '3.2'

gem 'sinatra', '~> 3.0'
gem 'puma', '~> 6.0'
# Add other gems here as needed (e.g., activerecord, pg)
RUBY

cat > Gemfile.lock <<'LOCK'
GEM
  remote: https://rubygems.org/
  specs:

DEPENDENCIES
  puma (~> 6.0)
  sinatra (~> 3.0)

PLATFORMS
  ruby

BUNDLED WITH
   2.4.13
LOCK

cat > config.ru <<'RU'
# Rackup configuration
require './app'
run Sinatra::Application
RU

cat > config/puma.rb <<'PUMA'
# Puma configuration
workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))
threads_count = Integer(ENV.fetch('MAX_THREADS', 5))
threads threads_count, threads_count

preload_app!

port        ENV.fetch('PORT', 4567)
environment ENV.fetch('RACK_ENV', 'production')

# Optional: pidfile, stdout_redirect, etc.
PUMA

cat > Dockerfile <<'DOCKER'
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
DOCKER

cat > .dockerignore <<'DOCKERIGNORE'
.git
log/*
tmp/*
.bundle
vendor/bundle
*.gem
*.lock
node_modules
DOCKERIGNORE

cat > .gitignore <<'GITIGNORE'
# Ruby & Bundler
/.bundle
/log
/tmp
/.env
/vendor/bundle
*.gem
*.rbc

# OS
.DS_Store
Thumbs.db

# Editor
*.swp
*.swo
.idea/
.vscode/

# Docker
.env.local
GITIGNORE

cat > docker-compose.yml <<'DC'
version: '3.8'

services:
  web:
    build: .
    ports:
      - "4567:4567"
    environment:
      RACK_ENV: production
      PORT: 4567
    restart: unless-stopped
DC

cat > README.md <<'MD'
# learn_something — Self-hosted Ruby web starter

This repository is prepared to run a small Sinatra web app with Puma and Docker.

Quick start (local)
1. Install Ruby 3.2 and Bundler.
2. bundle install
3. bundle exec puma -C config/puma.rb
4. Open http://localhost:4567

Quick start (Docker)
1. docker build -t learn_something:latest .
2. docker run -p 4567:4567 --env RACK_ENV=production learn_something:latest
3. Open http://SERVER_IP:4567

Using docker-compose
1. docker-compose up --build -d
2. Visit http://SERVER_IP:4567

Production deployment suggestions
- Reverse proxy with nginx (see `deploy/nginx/learn_something.conf`) and obtain TLS certs via certbot / Let's Encrypt.
- Run the app in Docker or as a systemd service (see `deploy/systemd/learn_something.service`).
- Use Postgres (external) for persistent data. Add `pg` to Gemfile and configure ENV vars for DB.
- Set `RACK_ENV=production` and configure secrets / environment variables via your host or orchestrator.
MD

cat > .env.example <<'ENV'
# Example environment variables
RACK_ENV=production
PORT=4567
WEB_CONCURRENCY=2
MAX_THREADS=5

# If you add DB:
# DATABASE_URL=postgres://user:pass@hostname:5432/dbname
ENV

cat > .github/workflows/ci.yml <<'CI'
name: CI

on:
  push:
    branches: [ main, scaffold/sinatra-puma-docker ]
  pull_request:
    branches: [ main ]

jobs:
  test-and-build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.2
      - name: Install dependencies
        run: |
          gem install bundler
          bundle install --jobs 4 --retry 3
      - name: Run linters / tests
        run: |
          # Add test commands here when tests exist
          echo "No tests configured"
      - name: Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: learn_something:ci
CI

cat > deploy/nginx/learn_something.conf <<'NGINX'
# nginx site config (place in /etc/nginx/sites-available/learn_something)
upstream learn_something_upstream {
    server 127.0.0.1:4567;
}

server {
    listen 80;
    server_name example.com; # replace with your domain

    location / {
        proxy_pass http://learn_something_upstream;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Frame-Options SAMEORIGIN;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }

    # Redirect /.well-known for certbot if needed
}
NGINX

cat > deploy/systemd/learn_something.service <<'SYSTEMD'
[Unit]
Description=learn_something Puma Service
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/var/www/learn_something
Environment=RACK_ENV=production
ExecStart=/usr/bin/bash -lc 'bundle exec puma -C config/puma.rb'
Restart=always

[Install]
WantedBy=multi-user.target
SYSTEMD

# Git add / commit / push
git add .
git commit -m "scaffold: add Sinatra + Puma + Docker (full scaffold)" || {
  echo "No changes to commit (maybe files already identical)"; exit 0;
}
git push -u origin scaffold/sinatra-puma-docker
echo "Done: files created and pushed to origin/scaffold/sinatra-puma-docker"
