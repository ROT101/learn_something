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
