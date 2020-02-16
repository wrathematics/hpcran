#!/bin/sh

DB="/hpcran/backend/uploaders.db"
if [ ! -f "${DB}" ]; then
  echo "ERROR: db already exists"
  exit 1
fi



QUERY="PRAGMA TABLE_INFO(users);"
echo "$QUERY" | sqlite3 ${DB}

echo ""
QUERY="SELECT * FROM users;"
echo "$QUERY" | sqlite3 ${DB}
