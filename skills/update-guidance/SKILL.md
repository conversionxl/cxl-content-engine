---
name: update-guidance
description: Set the priorities for an article refresh before running the audits, folding in the user's own steering on what to focus on and what to leave alone.
---

# Update guidance

Decide what this refresh is for before changing anything. A quick planning step that keeps
the update focused instead of rewriting things that were fine.

## Input

- Extracted article: `projects/content-engine/content/updates/1-extracted/{slug}.md`
- Any steering context the user gave the update pipeline.

## Steps

1. Skim the article and form a view of its current state: what still holds up, what looks
   dated, what is thin.
2. **Triage the content type.** Decide whether this piece is worth refreshing at all. Generic
   top-of-funnel explainers are the content type AI Overviews and answer engines have hit
   hardest, so a refresh may not pay back. A specific, decision-stage, or product-tied piece
   is usually worth the effort. Say which this is and whether to proceed, slim down, or
   consolidate it into a stronger page.
3. **Judge success beyond traffic.** Many good B2B pages now show "traffic down, revenue up":
   they still influence buyers and get cited by answer engines even as sessions fall. Do not
   treat a traffic dip as proof the page failed. Note whether the goal of this refresh is
   traffic, citations and brand representation, or conversion, because that changes the edits.
4. **Read the page's own search data, if you have it.** If Search Console is `on` in
   `projects/content-engine/your-setup/data-sources.md`, or the page appears in an export in
   `projects/content-engine/inputs/search-console/` or in the latest file in
   `projects/content-engine/content/opportunities/`, pull its top queries with clicks,
   impressions, CTR and position, and say which case this is:
   - **Seen but not clicked** (high impressions, position 1 to 10, low CTR): the title and
     description are the first fix. Note it for the `title-and-meta` skill (not a step of this pipeline: the command offers it when the run ends) and keep the body
     edits light.
   - **Close to winning** (position 5 to 20): depth, structure and freshness are the job.
   - **Losing ground** (clicks or impressions falling): find what changed in the results
     before deciding what to rewrite.
   - **Queries with no section** (impressions on a query the article barely covers): add
     them to the topic gaps.
   With no search data, say so and skip this step. Never estimate the numbers.
   If site analytics is `on`, also pull the page's sessions, engagement and conversions.
   A page with falling traffic and steady conversions is still doing its job: say so, and
   set the goal of the refresh to match (see step 3).
5. Fold in the user's steering. If they said focus on X or leave Y alone, that wins.
6. Set clear priorities across the audits that follow: outdated claims, missing product or
   feature mentions, and topic gaps versus the current SERP and answer engines.
7. Note anything off-limits: sections the user does not want touched, a voice or angle to
   preserve.

## Output

Write to `projects/content-engine/content/updates/0-guidance/{slug}.md`: the goal of this refresh, the priorities
in order, the search data case if there is one, and any do-not-touch notes. The audit skills read this so they pull in one
direction.

**Conversions:** count only the event named on the "Conversion event" line of `data-sources.md`. If it says "not set", report sessions and engagement and say conversions were not read. Never treat "key events" as sales.
