#!/usr/bin/env bash
# Formats the Dart file Claude Code just wrote.
#
# Wired to PostToolUse (Edit|Write|MultiEdit) in .claude/settings.json. Reads the
# hook payload on stdin and exits 0 in every case: a formatter is not allowed to
# fail a tool call. Generated output is skipped -- AGENTS.md forbids hand-editing
# *.g.dart and *.freezed.dart, and build_runner owns their formatting.
set -uo pipefail

file="$(python3 -c 'import json, sys
try:
    payload = json.load(sys.stdin)
except Exception:
    sys.exit(0)
tool_input = payload.get("tool_input") or {}
tool_response = payload.get("tool_response") or {}
print(tool_response.get("filePath") or tool_input.get("file_path") or "")' 2>/dev/null)"

[ -n "$file" ] || exit 0

case "$file" in
  *.g.dart | *.freezed.dart) exit 0 ;;
  *.dart) ;;
  *) exit 0 ;;
esac

[ -f "$file" ] || exit 0
command -v dart >/dev/null 2>&1 || exit 0

dart format "$file" >/dev/null 2>&1 || true
exit 0
