#!/usr/bin/env bash
# scripts/setup-hooks.sh - wire ~/.claude/git-hooks for this repo.
#
# Per ~/.claude/rules/known-hooks.md + ~/.claude/rules/never-bypass-hooks-silently.md.
# Idempotent: safe to re-run.

set -euo pipefail

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "ERROR: not inside a git repo"
  exit 1
fi

HOOK_PATH="$HOME/.claude/git-hooks"

if [ ! -d "$HOOK_PATH" ]; then
  echo "ERROR: $HOOK_PATH does not exist."
  echo "Install dotclaude first: https://github.com/sltbrta/dotclaude"
  exit 1
fi

HOOKS_DIR="$(git rev-parse --git-dir)/hooks"
LOCAL_OVERRIDES=""
if [ -d "$HOOKS_DIR" ]; then
  for hook in "$HOOKS_DIR"/*; do
    [ -e "$hook" ] || continue
    case "$hook" in
      *.sample) continue ;;
    esac
    LOCAL_OVERRIDES="${LOCAL_OVERRIDES}${hook##*/}"$'\n'
  done
fi

if [ -n "$LOCAL_OVERRIDES" ]; then
  echo "WARN: local .git/hooks/ has non-sample files (will override global):"
  while IFS= read -r hook; do
    [ -n "$hook" ] && printf '  %s\n' "$hook"
  done <<<"$LOCAL_OVERRIDES"
  echo "Decide whether to delete them, then re-run."
fi

CURRENT=$(git config --local core.hooksPath 2>/dev/null || echo "")
if [ "$CURRENT" = "$HOOK_PATH" ]; then
  echo "core.hooksPath already set to $HOOK_PATH"
else
  git config --local core.hooksPath "$HOOK_PATH"
  echo "set local core.hooksPath = $HOOK_PATH"
fi

if [ -x "$HOOK_PATH/pre-push" ]; then
  echo "pre-push hook present at $HOOK_PATH/pre-push"
else
  echo "WARN: $HOOK_PATH/pre-push missing or not executable"
fi

echo ""
echo "Done. Hooks active. Test by attempting a no-op push: git push --dry-run"
