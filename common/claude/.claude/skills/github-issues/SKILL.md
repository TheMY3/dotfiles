---
name: github-issues
description: Use when creating, editing, labeling, linking, closing or reviewing GitHub issues in any of the user's repos — backlog overview ("что осталось"), deferring an idea, scheduling a post-release check, splitting a plan into sub-issues. Common labels, title and body rules, links and closing for all projects.
---

# GitHub Issues

Backlog, ideas, research and deferred measurements live in the repo's Issues. Claude files
most of them, so the rules live here, shared across all projects. No GitHub Projects:
order comes from labels and parent issues.

## Labels

An issue has exactly one `type:`, any number of `area:`, and a `status:` only when it is not
"decided, doing it".

| Label | When |
|---|---|
| `type: bug` | Something is broken |
| `type: enhancement` | Work: feature, content, outreach |
| `type: research` | Data analysis, no code. Closed once the conclusion is written; next steps are separate issues |
| `type: check` | Measure an effect on a date. Date in the title |
| `status: idea` | Not decided: needs a decision or a spec |
| `status: blocked` | Waiting on a date, data or another issue. Comment says what we wait for and until when |
| `priority: high` | Take next. Used rarely; otherwise parent issues set the order |
| `area: …` | Per project. Meaning is in the label description: `gh label list` |

No `status:` means approved and in the backlog. "In progress" has no label: an open PR shows
it. Labels dependabot puts on its PRs (`dependencies`, `php`, …) are left alone.

A new `area:` only if people will actually filter by it; a label description is mandatory.

```bash
gh issue list --label "status: idea"   # awaiting a decision
gh issue list --label "type: check"    # deferred measurements
gh issue list --search '-label:"type: check"'   # backlog without checks
gh issue list --search "no:label"      # unlabeled — label them
```

### New repository

Base labels (`--force` updates color and description if the label exists):

```bash
gh label create "type: bug" -c d73a4a -d "Something is broken" --force
gh label create "type: enhancement" -c a2eeef -d "Work to do: feature, content, outreach" --force
gh label create "type: research" -c c5def5 -d "Data analysis, no code; close once the conclusion is written" --force
gh label create "type: check" -c 5319e7 -d "Measure an effect on a date (date in the title)" --force
gh label create "status: idea" -c fef2c0 -d "Not decided yet: needs a decision or a spec" --force
gh label create "status: blocked" -c fbca04 -d "Waiting on a date, data or another issue" --force
gh label create "priority: high" -c b60205 -d "Take next" --force
```

Rename GitHub's default labels (`bug`, `enhancement`) rather than adding new ones next to them
(`gh label edit bug --name "type: bug"`): a renamed label stays on old issues. Delete the other
defaults (`good first issue`, `wontfix`, `duplicate`…): close reasons replace them.

## Title and body

- **Write issues in Russian**, no prefixes like `SEO:` or `Идея:`: labels carry type and area.
- `type: check`: `Замер: <что> (YYYY-MM-DD)`, several dates comma-separated. For each date,
  a TickTick reminder linking to the issue.
- An issue is self-contained: data, sources, baseline and decision in the body, no links to Claude sessions.
- Don't repeat the status in the body ("Одобрено", "Идея", "Отложено", "делать не сейчас"): it's in the label.
  Why the status changed goes in a comment.
- A decision reached in comments is moved into the body: the body is the current state,
  comments are history.

## Links

- A big plan is a parent issue, its parts are sub-issues:
  `gh issue edit <parent> --add-sub-issue <n>` or `gh issue create --parent <parent>`.
- Waiting on another issue — native link plus `status: blocked`:
  `gh issue edit <n> --add-blocked-by <m>`. A plain "ждём #m" in text is not enough.
- A post-release measurement is a separate `type: check` with the baseline inside, not a comment on the old research.
- A `type: check` is a sub-issue of the work it measures, not of the plan: otherwise the plan stays open until the last check date.
- Closing a parent while parts are still open — move them to a live parent or detach them
  (`gh issue edit <n> --remove-parent`).

## Closing

- Done: `Closes #N` in the PR.
- Rejected or deferred: close as **not planned** (`gh issue close N --reason "not planned"`)
  with the reason and the condition for coming back. The issue stays searchable, the research isn't repeated.
  No open "someday" issues: they never show up in "что осталось" overviews.
- Duplicate: close as **duplicate** linking the main issue.
