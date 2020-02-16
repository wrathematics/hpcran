#!/bin/sh

DB="/hpcran/backend/uploaders.db"
if [ -f "${DB}" ]; then
  echo "ERROR: db already exists"
  exit 1
fi



QUERY="
CREATE TABLE users(
  id      INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
  account TEXT                               NOT NULL
);
"

echo "$QUERY" | sqlite3 ${DB}
