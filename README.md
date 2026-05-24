# template-repo

Sammy's GitHub template for new repos. Pre-loaded with the per-repo files needed for the 3-layer review workflow (`~/.claude/rules/greptile-pr-gate.md`) and the modularity / merge-gate disciplines.

## What's encoded in this template

| Rule | File(s) | Enforcement layer |
|---|---|---|
| `code-modularity-standards.md` (<=500 LOC) | `.github/workflows/file-size-gate.yml`, `scripts/check-file-size.sh`, `.file-size-allow-list` | CI gate + local script |
| `quality-toolchain-pre-merge.md` (lint + type + sec) | `pyproject.toml`, `biome.json`, `.pre-commit-config.yaml`, `.github/workflows/quality.yml`, `.github/workflows/lint.yml` | Pre-commit + CI |
| `greptile-pr-gate.md` (3-bot review) | `.coderabbit.yaml`, Ruleset config via `bootstrap.sh` | Branch protection + draft-first discipline |
| `code-ownership.md` (CODEOWNERS) | `CODEOWNERS`, `.github/workflows/codeowners-check.yml` | Required reviews + validation |
| `hermetic-builds.md` (pinned toolchain) | `.nvmrc`, `.python-version`, lockfile-frozen CI once projects add lockfiles | Build determinism |
| `never-bypass-hooks-silently.md` | `scripts/setup-hooks.sh` (wires `core.hooksPath`) | Local + pre-push gate |
| `monorepo-strategy.md` (workspaces) | `package.json` workspaces, `pyproject.toml` uv baseline | Repo layout |
| `testing-pyramid.md` (70/20/10) | `docs/CONVENTIONS.md` | Discipline (no CI enforcement) |
| `function-first-composition.md` | `docs/CONVENTIONS.md` | Discipline (PR review) |
| `one-function-per-file.md` | `docs/CONVENTIONS.md` | Discipline (PR review) |
| `feature-flags.md` | `docs/CONVENTIONS.md` | Discipline (project-by-project) |
| `trunk-based-development.md` | `docs/CONVENTIONS.md` | Discipline (small PRs) |
| `parallel-phase-cadence.md` | `BOOTSTRAP.md` section 12 | Discipline (multi-PR waves) |

## How to use

1. Click **Use this template** on GitHub → create the new repo.
2. Clone locally + open `BOOTSTRAP.md` and walk through the per-new-repo setup (~5 minutes).
3. Replace this README's content with your project's actual README.

## What's included (per-repo only)

System-level rules + standards + skills + scripts live in `~/.claude/` (see [dotclaude](https://github.com/sltbrta/dotclaude)). The template contains only files that MUST live in the repo:

- **`.gitignore`** — Python + Node + macOS baseline
- **`.coderabbit.yaml`** — CR config for draft→ready review only (no per-commit noise)
- **`.github/workflows/file-size-gate.yml`** — enforces 500-line file cap per `~/.claude/rules/code-modularity-standards.md`
- **`.github/workflows/quality.yml`** — multi-language quality gate for Python + TS/JS projects
- **`.github/workflows/codeowners-check.yml`** — validates CODEOWNERS syntax and references
- **`.github/pull_request_template.md`** — DONE-gate checklist per `~/.claude/rules/truth-seeking-discipline.md`
- **`biome.json` / `tsconfig.base.json` / `pyproject.toml`** — baseline lint, format, type, and security config
- **`.pre-commit-config.yaml`** — Layer 1 local quality hook scaffold
- **`scripts/setup-hooks.sh`** — wires repo-local `core.hooksPath` to `~/.claude/git-hooks`
- **`scripts/check-file-size.sh`** — local + CI file-size gate
- **`CODEOWNERS`** — default @sltbrta; replace per-project
- **`CONTRIBUTING.md` / `docs/CONVENTIONS.md` / `docs/MIGRATION-CHECKLIST.md`** — repo-local operating docs
- **`docs/ROADMAP.md`** — template per `~/.claude/rules/unified-roadmap-discipline.md`
- **`.claude/`** — empty placeholder for per-project scratch (memory / plans / handovers / audits — all git-ignored)
- **`LICENSE`** — MIT default; swap if needed

## What's NOT included (system-level)

These live in `~/.claude/` and load automatically per Claude Code's import system:

- All rules (`~/.claude/rules/*.md`) — 28+ disciplines including 3-layer review, audit-all-Ps, code-modularity, monitor-discipline, etc.
- All standards (`~/.claude/standards/`) — PRODUCTION_GRADE_CODE.md + language-specific
- All skills (`~/.claude/skills/`) — external-handover + others
- Constitution, MEMORY.md, cross-project-lessons, hooks
