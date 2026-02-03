set -euo pipefail

# Safety: check branch
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$BRANCH" != "scaffold/sinatra-puma-docker" ]; then
  echo "Error: you must run this script on branch scaffold/sinatra-puma-docker (current: $BRANCH)"
  exit 1
fi

# Create directories
mkdir -p deploy/nginx deploy/systemd .github/workflows config

# Write files
cat > app.rb <<'RUBY'
# Simple Sinatra application
require 'sinatra'
require 'sinatra/activerecord'
require 'json'

# Configure database
set :database, ENV['DATABASE_URL'] || 'postgresql://localhost/learn_something_development'


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
ruby '3.2.3'

gem 'sinatra', '~> 3.0'
gem 'puma', '~> 6.0'
gem 'activerecord', '~> 7.0'          # ORM
gem 'sinatra-activerecord', '~> 2.0'  # integration helpers (optional but handy)
gem 'pg'                              # Postgres adapter
gem 'bcrypt', '~> 3.1'                # secure password hashing
gem 'redcarpet'                       # markdown rendering
gem 'rake'                            # for migrations/tasks
gem 'sinatra-contrib'                 # helpful helpers (sessions, etc.)
# for tests:
gem 'rack-test', group: :test
gem 'minitest', group: :test
# Add other gems here as needed (e.g., activerecord, pg, sinatra-activerecord)
RUBY

cat > Gemfile.lock <<'LOCK'
GEM
  remote: https://rubygems.org/
  specs:
    mustermann (3.0.0)
      ruby2_keywords (~> 0.0.1)
    nio4r (2.5.9)
    puma (6.4.2)
      nio4r (~> 2.0)
    rack (3.0.10)
    rack-protection (4.0.0)
      rack (~> 3.0)
    ruby2_keywords (0.0.5)
    sinatra (3.2.0)
      mustermann (~> 3.0)
      rack (~> 3.0)
      rack-protection (= 3.0.0)
      tilt (~> 2.0)
    tilt (2.3.0)

DEPENDENCIES
  puma (~> 6.0)
  sinatra (~> 3.0)

PLATFORMS
  x86_64-linux
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
DOCKER

cat > docker-compose.yml <<'DC'

services:
  web:
    build: .
    ports:
      - "4567:4567"
    environment:
      RACK_ENV: production
      PORT: 4567
      WEB_CONCURRENCY: 2
      MAX_THREADS: 5
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4567/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
DC

# Add a simple docker-compose for development
cat > docker-compose.dev.yml <<'DCDEV'

services:
  web:
    build: .
    ports:
      - "4567:4567"
    environment:
      RACK_ENV: development
      PORT: 4567
    volumes:
      - .:/app
      - bundle_data:/usr/local/bundle
    command: bundle exec puma -C config/puma.rb

volumes:
  bundle_data:
DCDEV

cat > .dockerignore <<'DOCKERIGNORE'
.git
.gitignore
log/*
tmp/*
*.log
*.pid
*.swp
*.swo
.DS_Store
.idea/
.vscode/
.env*
docker-compose.override.yml
README.md
deploy/
.github/
coverage/
spec/
test/
node_modules/
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
.bundle
Gemfile.lock
*.gem

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
.env.*.local

# Logs
*.log
GITIGNORE

# Write README.md separately to avoid delimiter issues
cat > README.md <<'README_MARKDOWN'
# learn_something — Self-hosted Ruby web starter

This repository is prepared to run a small Sinatra web app with Puma and Docker.

## Quick start (local development)
1. Install Ruby 3.2 and Bundler.
2. \`bundle install\`
3. \`bundle exec puma -C config/puma.rb\`
4. Open http://localhost:4567

## Quick start (Docker)
1. \`docker build -t learn_something:latest .\`
2. \`docker run -p 4567:4567 --env RACK_ENV=production learn_something:latest\`
3. Open http://localhost:4567

## Using docker-compose
### Production:
\`\`\`bash
docker-compose up --build -d
\`\`\`

### Development (with hot reload):
\`\`\`bash
docker-compose -f docker-compose.dev.yml up --build
\`\`\`

## Production deployment suggestions
- Reverse proxy with nginx (see \`deploy/nginx/learn_something.conf\`) and obtain TLS certs via certbot / Let's Encrypt.
- Run the app in Docker or as a systemd service (see \`deploy/systemd/learn_something.service\`).
- Use Postgres (external) for persistent data. Add \`pg\` to Gemfile and configure ENV vars for DB.
- Set \`RACK_ENV=production\` and configure secrets / environment variables via your host or orchestrator.

## Health Check
The application includes a health endpoint at \`/health\` that returns 200 OK.
README_MARKDOWN

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
          ruby-version: 3.2.3
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
      - name: Test Docker container
        run: |
          docker build -t learn_something:test .
          docker run -d -p 4567:4567 --name test-app learn_something:test
          sleep 5
          curl -f http://localhost:4567/health
          docker stop test-app && docker rm test-app
CI

cat > deploy/nginx/learn_something.conf <<'NGINX'
# nginx site config (place in /etc/nginx/sites-available/learn_something)
upstream learn_something_upstream {
    server 127.0.0.1:4567;
    # For multiple instances (load balancing):
    # server 127.0.0.1:4568;
    # server 127.0.0.1:4569;
    keepalive 32;
}

server {
    listen 80;
    server_name example.com; # replace with your domain
    client_max_body_size 10M;

    location / {
        proxy_pass http://learn_something_upstream;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Port $server_port;
        
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    location /health {
        proxy_pass http://learn_something_upstream;
        proxy_set_header Host $host;
        access_log off;
    }

    # Redirect /.well-known for certbot if needed
    location /.well-known {
        root /var/www/html;
    }
}
NGINX

cat > deploy/systemd/learn_something.service <<'SYSTEMD'
[Unit]
Description=learn_something Puma Service
After=network.target

[Service]
Type=simple
User=www-data
Group=www-data
WorkingDirectory=/var/www/learn_something
Environment=RACK_ENV=production
Environment=PORT=4567
Environment=WEB_CONCURRENCY=2
Environment=MAX_THREADS=5
ExecStart=/usr/local/bin/bundle exec puma -C config/puma.rb
Restart=always
RestartSec=5
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=learn_something

# Security hardening
PrivateTmp=true
ProtectSystem=full
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
SYSTEMD

# Create a simple test script
cat > test_app.sh <<'TEST'
#!/bin/bash
set -e

echo "Testing the application..."
echo "1. Checking Ruby version..."
ruby --version

echo "2. Checking bundle install..."
bundle check || bundle install

echo "3. Starting Puma in background..."
bundle exec puma -C config/puma.rb &
PID=$!

echo "4. Waiting for server to start..."
sleep 3

echo "5. Testing health endpoint..."
curl -f http://localhost:4567/health
echo ""
echo "6. Testing main endpoint..."
curl -f http://localhost:4567/
echo ""

echo "7. Stopping server..."
kill $PID

echo "Test completed successfully!"
TEST

chmod +x test_app.sh

# Git add / commit / push
git add .
git commit -m "scaffold: add Sinatra + Puma + Docker (full scaffold with fixes)" || {
  echo "No changes to commit (maybe files already identical)"; exit 0;
}
git push -u origin scaffold/sinatra-puma-docker
echo "Done: files created and pushed to origin/scaffold/sinatra-puma-docker"
echo ""
echo "Next steps:"
echo "1. Switch to the scaffold branch: git checkout scaffold/sinatra-puma-docker"
echo "2. Test locally: ./test_app.sh"
echo "3. Test with Docker: docker-compose up --build"