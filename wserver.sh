#!/usr/bin/env sh
set -e
exec waitress-serve --host 0.0.0.0 --port 5000 flask_app:app
