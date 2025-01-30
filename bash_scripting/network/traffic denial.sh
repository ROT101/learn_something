#!/bin/env bash

# Deny all incoming traffic
ufw default deny incoming
echo "All incoming traffic denied"