# template-repo

Sammy's GitHub template for new repos. Pre-loaded with the per-repo files needed for the 3-layer review workflow (`~/.claude/rules/greptile-pr-gate.md`) and the modularity / merge-gate disciplines.

## How to use

1. Click **Use this template** on GitHub → create the new repo.
2. Clone locally + open `BOOTSTRAP.md` and walk through the per-new-repo setup (~5 minutes).
3. Replace this README's content with your project's actual README.

## What's included (per-repo only)

System-level rules + standards + skills + scripts live in `~/.claude/` (see [dotclaude](https://github.com/sltbrta/dotclaude)). The template contains only files that MUST live in the repo:

- **`.gitignore`** — Python + Node + macOS baseline
- **`.coderabbit.yaml`** — CR config for draft→ready review only (no per-commit noise)
- **`.github/workflows/file-size-gate.yml`** — enforces 500-line file cap per `~/.claude/rules/code-modularity-standards.md`
- **`.github/pull_request_template.md`** — DONE-gate checklist per `~/.claude/rules/truth-seeking-discipline.md`
- **`CODEOWNERS`** — default @sltbrta; replace per-project
- **`docs/ROADMAP.md`** — template per `~/.claude/rules/unified-roadmap-discipline.md`
- **`.claude/`** — empty placeholder for per-project scratch (memory / plans / handovers / audits — all git-ignored)
- **`LICENSE`** — MIT default; swap if needed

## What's NOT included (system-level)

These live in `~/.claude/` and load automatically per Claude Code's import system:

- All rules (`~/.claude/rules/*.md`) — 28+ disciplines including 3-layer review, audit-all-Ps, code-modularity, monitor-discipline, etc.
- All standards (`~/.claude/standards/`) — PRODUCTION_GRADE_CODE.md + language-specific
- All skills (`~/.claude/skills/`) — external-handover + others
- Constitution, MEMORY.md, cross-project-lessons, hooks
