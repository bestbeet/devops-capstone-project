#!/usr/bin/env bash
# Capture REAL REST API evidence from a running Accounts service.
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8000}"
mkdir -p evidence

payload='{"name":"Capstone Test","email":"capstone@example.com","address":"123 Test Street","phone_number":"0123456789","date_joined":"2026-11-17"}'

printf 'curl -i -X POST %s/accounts -H "Content-Type: application/json" -d %s\n\n' "$BASE_URL" "$payload" > evidence/rest-create-done
curl -i -sS -X POST "$BASE_URL/accounts" -H "Content-Type: application/json" -d "$payload" >> evidence/rest-create-done

id=$(curl -sS "$BASE_URL/accounts" | python3 -c 'import json,sys; accounts=json.load(sys.stdin); a=[x for x in accounts if x.get("email")=="capstone@example.com"]; print(a[-1]["id"] if a else "")')
if [[ -z "$id" ]]; then
  echo "Could not locate created account. Check the service and database." >&2
  exit 1
fi

printf 'curl -i %s/accounts\n\n' "$BASE_URL" > evidence/rest-list-done
curl -i -sS "$BASE_URL/accounts" >> evidence/rest-list-done

printf 'curl -i %s/accounts/%s\n\n' "$BASE_URL" "$id" > evidence/rest-read-done
curl -i -sS "$BASE_URL/accounts/$id" >> evidence/rest-read-done

updated='{"name":"Capstone Updated","email":"capstone@example.com","address":"456 Test Avenue","phone_number":"0123456789","date_joined":"2026-11-17"}'
printf 'curl -i -X PUT %s/accounts/%s -H "Content-Type: application/json" -d %s\n\n' "$BASE_URL" "$id" "$updated" > evidence/rest-update-done
curl -i -sS -X PUT "$BASE_URL/accounts/$id" -H "Content-Type: application/json" -d "$updated" >> evidence/rest-update-done

printf 'curl -i -X DELETE %s/accounts/%s\n\n' "$BASE_URL" "$id" > evidence/rest-delete-done
curl -i -sS -X DELETE "$BASE_URL/accounts/$id" >> evidence/rest-delete-done

echo "Actual API evidence captured in evidence/rest-*-done (Account ID: $id)"
