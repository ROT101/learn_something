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
