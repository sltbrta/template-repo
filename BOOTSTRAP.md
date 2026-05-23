# Bootstrap a new repo from this template

One-time checklist. ~5 minutes. Per `~/.claude/rules/greptile-pr-gate.md`.

## 1. Repo creation

- [ ] Click **Use this template** → create the new repo under `tokoyo-labs/<name>` (or appropriate org).
- [ ] Clone locally: `git clone git@github.com:tokoyo-labs/<name>.git && cd <name>`.

## 2. Replace template-isms

- [ ] Edit `README.md` — replace template description with project description.
- [ ] Edit `CODEOWNERS` — adjust ownership if not @sltbrta.
- [ ] Edit `docs/ROADMAP.md` — initialize Track A + first deliverables.
- [ ] Edit `LICENSE` — if not MIT, replace with appropriate license.
- [ ] Edit `.coderabbit.yaml` — adjust `language` or `path_filters` per project if needed.

## 3. Install GitHub apps (one-time per repo)

- [ ] **CodeRabbit** — https://github.com/apps/coderabbitai — install on the new repo.
- [ ] **Greptile** — https://github.com/apps/greptile — install on the new repo. In Greptile dashboard → enable **"Create GitHub status check"** for this repo.
- [ ] **GitHub Copilot Code Review** — already enabled at org level; verify `Settings → Code review → Copilot code review` shows the repo opted-in.

## 4. Initial PR to populate status check names

Branch protection cannot reference status checks that have never run on the repo (GitHub returns `Invalid integration ids`). So:

- [ ] Create a trivial first PR (e.g., update this README with project description) as DRAFT.
- [ ] Mark ready for review: `gh pr ready 1`.
- [ ] Wait for CR + Greptile + Copilot to each post their status check (~5-10 minutes).
- [ ] Confirm with `gh pr checks 1` that 3 bot checks appear: `CodeRabbit`, `Greptile Review`, `Copilot Pull Request Reviewer`.

## 5. Branch protection / Ruleset

Per `~/.claude/rules/greptile-pr-gate.md` § "Set GitHub Ruleset for `main`":

- [ ] Go to **Settings → Rules → Rulesets → New ruleset**.
- [ ] Name: `Merge Checks`. Enforcement: **Active**. Bypass list: **empty**.
- [ ] Target branches: `Add target → Include default branch`.
- [ ] Branch rules — CHECK:
  - ✅ Restrict deletions
  - ✅ Require a pull request before merging
    - Required approvals: 1
    - Dismiss stale approvals on new commits
    - Require conversation resolution before merging
  - ✅ Require status checks to pass
    - Require branches to be up to date before merging
    - Add: `CodeRabbit`, `Greptile Review`, `Copilot Pull Request Reviewer`, + any CI workflow names (e.g., `file-size-gate`)
  - ✅ Block force pushes
- [ ] LEAVE UNCHECKED:
  - ❌ Require code scanning results (no CodeQL installed by default)
  - ❌ Require linear history (preference — enable if you want squash-only)
  - ❌ Require signed commits (preference)
- [ ] Save the ruleset.

## 6. CI environment

The `file-size-gate.yml` workflow runs on every PR. No additional setup needed.

If the project uses Python:
- [ ] Initialize `pyproject.toml` with the ruff/radon config snippet from `~/.claude/rules/code-modularity-standards.md`.
- [ ] Add `uv sync` + `uv run pytest` workflows as needed.

## 7. First commit

- [ ] After bootstrap, commit any local edits to the template files.
- [ ] Push (will require PR — branch protection is now active).

## 8. Update dotclaude memory

Once bootstrap complete, add a per-project memory entry:

```
~/.claude/projects/-Users-sammy-Developer-<project>/memory/feedback_two_bot_gate_active.md
```

Note: date enabled, exact status-check names confirmed for this repo, any per-repo .coderabbit.yaml overrides.

---

Done. New PRs follow the 3-layer model: pre-commit dispatch agent review → draft iteration → ready-for-review triggers both bot gates.
