#!/bin/bash

echo "${POSTGRES_HOST}:*:*:"${POSTGRES_USER}":"${POSTGRES_PASSWORD} > ~/.pgpass
chmod 0600 ~/.pgpass

"$@"
