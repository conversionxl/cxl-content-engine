---
name: title-and-meta
description: Rewrite a page's title and meta description so more searchers click, by reading the live search results for the query first and writing against them. Use on a page with high impressions and a low click-through rate, or before publishing an article.
---

# Title and meta description

Write the search result people choose. A title is never written in isolation: it competes
with nine others on the same page, so read those first.

## Input

- The page (a URL, or a draft in `projects/content-engine/content/`) and its target query.
- The current title and meta description, if published.
- If Search Console is on in `projects/content-engine/your-setup/data-sources.md`, the
  page's impressions, CTR and position for that query. If not, do not guess them.

## Step 1: understand the query

Name the intent in one line: is the searcher learning, comparing, or ready to choose? Name
who they are, from `your-offer.md`.

## Step 2: read the search results

Search the query and list the title and description of each top result. Then note:

- the words and structures nearly all of them share
- the angle they all take
- the angle none of them takes
- which ones are vague, and which make a clear promise

## Step 3: find what is weak in the current title

Is it unclear, generic, the same as everyone else's, promising something the page does not
deliver, or aimed at a different intent than the query?

## Step 4: write the options

A good title:

- matches the query in the searcher's own words
- says what the reader gets
- is specific: a number, an outcome or a named audience, only when the page delivers it
- reads differently from the results around it

Relevance beats cleverness, and clarity beats creativity. No clickbait: a title that wins
the click and breaks its promise loses the reader and, in time, the ranking. Follow the
voice in `brand-and-voice.md`.

The meta description backs the title up: what is on the page, for whom, and why this result
over the others. Plain and direct, no keyword stuffing.

## Output

Write `projects/content-engine/content/opportunities/title-{slug}.md`:

1. **What the results look like:** the shared pattern and the gap, in three lines.
2. **Titles:** 3 to 5 options, the recommended one first with one line on why.
3. **Meta descriptions:** 2 to 3 options.
4. **How to check it worked:** compare CTR for this query over the 28 days after the change
   with the 28 days before, at a similar position.

Nothing is changed on the live page. The user makes the change, or asks for it. Never use em
dashes.

Credit: the search-results-first method comes from Tarek Reslan's CTR optimization skill,
taught in CXL's "Create research-backed and search-optimized content".
