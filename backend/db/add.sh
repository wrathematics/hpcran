#!/bin/sh

DB="/hpcran/backend/uploaders.db"
if [ ! -f "${DB}" ]; then
  echo "ERROR: db already exists"
  exit 1
fi



USER="$1"
if [ -z ${USER} ]; then
  echo "ERROR: supply a user to add"
  exit 1;
fi



QUERY="
INSERT INTO users(account)
VALUES('${USER}');
"

echo "$QUERY" | sqlite3 ${DB}
