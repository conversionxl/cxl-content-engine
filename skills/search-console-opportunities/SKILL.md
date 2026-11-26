---
name: search-console-opportunities
description: Read your Google Search Console data (a connected tool or an export) and find the pages and queries with real upside, each labelled as a title fix, a refresh, a new article or an intent mismatch, and ranked by likely impact. Use when deciding what to write or update next.
---

# Search Console opportunities

Turn your own search data into a short, ranked list of things to do. This is a decision, not
a report: a number only matters if it leads to an action.

## Input

Use the first that applies:

1. **Search Console connected** (`Google Search Console MCP` is `on` in
   `projects/content-engine/your-setup/data-sources.md`): pull queries and pages for the last
   28 days and the 28 days before, with clicks, impressions, CTR and average position.
2. **An export**: any CSV or sheet the user dropped in
   `projects/content-engine/inputs/search-console/` or pasted into the chat.
3. **Neither**: stop and say so. Explain the two options above. Do not estimate search data
   from web search, and never invent clicks, impressions or positions.

If `Google Analytics MCP` is `on`, also pull sessions, engagement and conversions for the
same landing pages. If it is off, skip pattern 5 and say you skipped it.

Leave out branded queries (the company and product names in `your-offer.md`) unless the user
asks for them: they hide the real picture.

## The five patterns to look for

| Pattern | What the data shows | What it means | Label |
|---|---|---|---|
| 1. Seen but not chosen | High impressions, position 1 to 10, CTR well below other queries at a similar position on this site | The title or description loses the click, or the page answers a different intent | Title fix |
| 2. Close to winning | Average position 5 to 20, meaningful impressions | The page is relevant but not yet competitive | Refresh |
| 3. Losing ground | Clicks or impressions down against the previous period on a page that used to perform | The content is ageing, or rivals now cover it better | Refresh |
| 4. Demand without a page | Queries with impressions where the ranking page only touches the topic | The topic needs its own article, or a new section if the intent is close | New article |
| 5. Visits that go nowhere | Strong search traffic, weak engagement or conversion (needs Analytics) | The page wins the click and fails the visitor, or attracts the wrong intent | Intent mismatch |

Compare CTR against this site's own numbers at a similar position, not against an industry
benchmark you cannot source.

## How to rank

Weigh four things, in this order:

1. **Traffic potential:** impressions, and how far the position could move.
2. **Likelihood of improvement:** a page at position 8 is more winnable than one at 45.
3. **Business value:** does the query lead to something in `your-offer.md`? A bottom-of-funnel
   query with 300 impressions outranks a generic one with 3,000.
4. **Effort:** a title fix is an hour, a rebuild is a week.

Drop anything with too few impressions to judge, and say what threshold you used.

## What each label leads to

| Label | Next step |
|---|---|
| Title fix | The `title-and-meta` skill on that page and query |
| Refresh | `/content-engine:update-pipeline "url"` |
| New article | `/content-engine:blog-pipeline "query"` |
| Intent mismatch | Read the page against the query first. Often a refresh with a different angle, sometimes a new page |

When the numbers conflict or a drop is sharp with no clear cause, say "needs a closer look"
and what you would check. Do not force a label.

## Output

Write `projects/content-engine/content/opportunities/search-console-{YYYY-MM-DD}.md`:

1. **Summary:** three lines. What stands out, where the biggest upside is, what to do first.
2. **Opportunities table:** page, query, clicks, impressions, CTR, position, label, why it
   matters, next step. Highest priority first, 15 rows at most.
3. **Top five next steps,** each as the exact command to run.
4. **What was not checked** and why (no Analytics, short date range, small sample).

Every recommendation cites the numbers it rests on. No generic SEO advice. Never use em
dashes.

Credit: the five patterns and the ranking order come from Tarek Reslan's SEO data analysis
skill, taught in CXL's "Create research-backed and search-optimized content".
