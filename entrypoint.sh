#!/bin/sh -l

set -e

if [ -z "$INPUT_ACCESS_TOKEN" ]; then
  echo "Error: access_token is required."
  exit 1
fi

if [ -z "$INPUT_HOST_NAME" ]; then
  echo "Error: host_name is required."
  exit 1
fi

if [ -z "$INPUT_MESSAGE" ]; then
  echo "Error: message is required."
  exit 1
fi

API_URL="https://${INPUT_HOST_NAME}${INPUT_API_PATH}"
ACCESS_TOKEN="$INPUT_ACCESS_TOKEN"
MESSAGE="$INPUT_MESSAGE"

RESPONSE=$(curl -s -w http_code -X POST "$API_URL" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"status\":\"$MESSAGE\"}")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
  echo "Successfully posted to Fediverse."
  echo "Response: $BODY"
else
  echo "Error: Failed to post to Fediverse."
  echo "HTTP Status Code: $HTTP_CODE"
  echo "Response: $BODY"
  exit 1
fi
