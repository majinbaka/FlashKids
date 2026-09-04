#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PORT="${WIDGETBOOK_PORT:-8090}"
HOST="${WIDGETBOOK_HOST:-0.0.0.0}"
LOG_FILE="${PROJECT_ROOT}/.widgetbook.log"

cd "${PROJECT_ROOT}"

echo "Stopping existing Widgetbook server on port ${PORT}..."
existing_pids="$(pgrep -f "flutter_tools.snapshot run -d web-server -t widgetbook/main.dart.*--web-port ${PORT}" || true)"
if [[ -n "${existing_pids}" ]]; then
  while read -r pid; do
    [[ -z "${pid}" ]] || kill "${pid}" 2>/dev/null || true
  done <<< "${existing_pids}"

  for _ in {1..20}; do
    if ! ss -ltn "sport = :${PORT}" | tail -n +2 | grep -q LISTEN; then
      break
    fi
    sleep 0.5
  done
fi

if ss -ltn "sport = :${PORT}" | tail -n +2 | grep -q LISTEN; then
  echo "Port ${PORT} is still in use; refusing to start Widgetbook." >&2
  exit 1
fi

echo "Starting Widgetbook at http://localhost:${PORT}"
flutter run \
  -d web-server \
  -t widgetbook/main.dart \
  --web-hostname "${HOST}" \
  --web-port "${PORT}" \
  2>&1 | tee "${LOG_FILE}"
