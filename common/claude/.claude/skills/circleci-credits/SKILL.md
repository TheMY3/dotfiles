---
name: circleci-credits
description: Use when CircleCI credits or storage run out, CI is slow or expensive, or the user wants to optimize/cheapen a CircleCI pipeline in any project (Laravel/PHP + node especially). Checklist of what to measure and which levers actually pay off, learned on a Laravel project (Oct 2026).
---

# Saving CircleCI credits

Learned on a Laravel project (October 2026): Free plan, 30,000 credits a month ran out
in two weeks. Measure first, cut second — intuition was wrong more than once.

## 1. Measure

- Credits per job — Insights API (personal `CIRCLECI_TOKEN`):
  `GET /api/v2/insights/gh/<org>/<repo>/workflows` → per workflow,
  `…/workflows/<wf>/jobs?all-branches=true` and `&branch=master` → per job.
  Look at `total_credits_used`, median duration, master's share.
- Job steps and their timing — `GET /api/v1.1/project/github/<org>/<repo>/<build_num>` → `steps[].actions[].run_time_millis`.
- Test timing — junit. Caveat: junit from `paratest --parallel` was incomplete
  (1064 of 1801) — run sequentially for honest numbers.
- Free: 2 GB·month storage and 1 GB network; beyond that **420 credits per GB** from the same pool.
  **Retention is not configurable on Free** (Plan → Usage Controls is paid-only):
  workspace and caches 15 days, artifacts 30. The only saving is in what you store.
- CircleCI MCP `circleci-hosted` (https://mcp.circleci.com/v1/mcp, OAuth, user scope):
  `list_runs` → `list_run_workflows` → `list_workflow_jobs` → `get_job` (step timing),
  `get_job_logs`, `get_job_resource_usage`, `download_usage_data` (`org: gh/<org>`, per-job
  CSV with credits). The old `@circleci/mcp-server-circleci` is deprecated; some of its
  tools fail on `next_page_token`.

## 2. Levers, biggest first

1. **Turn Xdebug off in tests: `-e XDEBUG_MODE=off`** in the test step's `docker run`.
   The dev image kept Xdebug in `develop` — all PHP twice as slow. Together with item 3
   (redundant seed) the CI test step went 213 → 64 s. Check the **effective** mode:
   `php -r 'var_dump(xdebug_info("mode"));'` — `ini_get` lies, env doesn't show it.
   Locally: `composer test` with `"@putenv XDEBUG_MODE=off"`; in `docker compose exec` — `-e XDEBUG_MODE=off`.
   **E2E too:** Xdebug in the php-fpm serving Cypress slows every page.
   Another project (Oct 2026): a mounted `docker/php-fpm/xdebug.ini` with
   `debug,develop,coverage` + `start_with_request=yes` → ~9 s per page; after
   `xdebug.mode=off` E2E 7:00 → 2:09, full run 10 → 4.6 min. Keep the file with `off`
   rather than removing it: the base PHP image defaults to `develop`.
   Per-spec timing — the table at the end of the E2E step log (`get_job_logs`).
2. **Don't collect coverage if nobody reads the number** (clover sat as an artifact
   with no consumer; xdebug coverage added +50% to the run).
3. **Tests running a heavy import/seed in every method** — the main CPU cost.
   Fix: one shared DB snapshot per process. SQLite `:memory:` + RefreshDatabase:
   the first test writes the imported tables to a file, the rest `ATTACH` +
   `DELETE`/`INSERT INTO main.t SELECT * FROM snap.t` inside their own transaction
   (18 ms vs 2–6 s). `DETACH` inside a transaction fails — keep it attached.
   Tests that verify the import itself stay honest.
4. **Skip the pipeline on docs-only commits** — dynamic config
   (`setup: true` + `circleci/continuation` orb; enable Project Settings → Advanced →
   "Enable dynamic config using setup workflows"). Setup job on `cimg/base`,
   `resource_class: small`, ~7 s: on master `git diff pipeline.git.base_revision..HEAD`,
   on a branch — from `merge-base` with master; only `docs/**`, `*.md` → `circleci-agent step halt`
   without continuation. Test the `grep` in plain bash (shell wrappers lie).
5. **No workspace**: each job does its own checkout and restores dependencies from cache.
   `persist_to_workspace ./*` with `vendor` on every run was the main storage cost.
6. **Cache npm at `~/.npm`, not `node_modules`**: `npm ci` wipes `node_modules`.
7. **Blade + paratest on a cold cache**: templates compile non-atomically, workers
   read a half-written file ("Unclosed '('" in a random test). Run `php artisan view:cache`
   before tests.

## 3. What barely helps

- **`resource_class` and docker instead of machine.** Tests are CPU-bound: large costs 2×
  and runs ~2× faster — same credits. Docker only saves overhead (~20 s of 230).
- **A cheap command called twice** — measure before fixing (it was 0.01 s).
- **Measurements taken with Xdebug on distort proportions.** An agent counted 35–40 s on a
  "catalog threshold" (5,000 stub rows in HTTP fakes); without Xdebug it was 3 s — not done.
  Turn Xdebug off first, then measure the rest.
- **A redundant seed before an import** can turn the first run from a baseline into an
  edit (a change log of tens of thousands of rows) — look for stale test helpers.

## 4. Re-running on master after a PR merge — don't (decided 2026-10-03)

The re-run was 40–48% of the projects' credits. In the setup job on master:
`git log --first-parent --format=%ce "$BASE..HEAD" | sort -u` — if it's only
`noreply@github.com` (merge or squash of a PR via GitHub), `circleci-agent step halt; exit 0`
(`halt` doesn't stop the script). Direct and mixed pushes still run tests.
Risk — a stale branch; branch protection / merge queue are unavailable on private Free repos.
