#!/usr/bin/env bash
set -e

URL="https://www.vpngate.net/api/iphone/"
OUT="data/iphone_api.json"
TMP="/tmp/iphone_api.tmp"

# web sahypadan maglumat alyp, wagtlaýyn faýla ýaz
curl -sSfL "$URL" -o "$TMP" || { echo "Fetch failed"; exit 2; }

# maglumat boş dälmi?
if [ ! -s "$TMP" ]; then
  echo "Boş maglumat geldi, commit ýok"
  exit 0
fi

# bukja bar bolsa goýmaga taýýarla
mkdir -p "$(dirname "$OUT")"

# öňki bilen deňeşdir
if [ ! -f "$OUT" ] || ! cmp -s "$TMP" "$OUT"; then
  mv "$TMP" "$OUT"
  git config user.name "github-actions[bot]"
  git config user.email "github-actions[bot]@users.noreply.github.com"
  git add "$OUT"
  git commit -m "Auto-update $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  git push
  echo "Täzelik bar → commit edildi"
else
  echo "Üýtgeşiklik ýok"
fi
