---
name: keyword-prioritization
description: Score and rank a list of keyword ideas by how well they fit the user's blog and how relevant they are to what the user sells. Use after content-gap-analysis.
---

# Keyword prioritization

Turn a raw list of keyword ideas into a ranked shortlist worth writing.

## Input

`projects/content-engine/content/keyword-ideas.csv` (from `content-gap-analysis`, or a list the user pastes in).

## Data to pull first

**Which tools to use.** Read `projects/content-engine/your-setup/data-sources.md`. A job is
covered when its row is `on`, whatever tool the row names (Ahrefs, Semrush, another). An
older setup file lists tools without jobs: read "Ahrefs MCP" as keyword and search results
data, "Google Search Console MCP" as search performance, "Google Analytics MCP" as site
analytics.

- **Keyword and search results data on:** for every keyword in the list, pull search
  volume, difficulty and parent topic, and note what kind of page ranks. Write them into the
  list. Fold keywords with the same parent topic into one row.
- **Search performance on:** mark keywords the user's site already ranks for, with the page
  and position. A keyword at position 12 is a refresh, not a new article.
- **Site analytics on:** find the pages that bring the most conversions, and lift keywords
  on the same topics.
- **A tool is off:** leave its columns blank. Do not estimate a volume. Say in the note
  which scores rest on judgment alone.

## Bottom of the funnel first

The default B2B mistake is ranking everything by search volume. Volume is sorted the same
way in every tool, so everyone chases the same high-volume generic terms. Instead, start at
the bottom of the funnel and work up. A smaller, high-intent topic that reaches a buyer who
is close to choosing is worth more than a big top-of-funnel term that reaches nobody who buys.

Boost keywords carrying **commercial-intent modifiers**: solution, platform, software, tool,
vendor, "best", "vs", alternative, comparison, pricing, and pain-point "how to" queries that
map to what the offer solves. Down-weight broad definitional terms.

## Optional input: what converts in paid

If the user runs Google Ads, ask whether they can share which keywords convert there (or
export it). What a company pays for and converts on is a strong signal for which organic
topics are worth winning. Use it to lift those topics in the ranking.

## How to score

For each keyword, rate 1 to 5 on:

1. **Intent and funnel stage:** how close is this searcher to a buying decision? Bottom-of-
   funnel and high-intent pain points score highest; generic top-of-funnel scores low even
   at high volume. This is the heaviest factor.
2. **Blog fit:** does it match the topics in `projects/content-engine/your-setup/brand-and-voice.md`? Off-topic
   keywords score low no matter how big.
3. **Product relevance:** can it lead naturally to something in `projects/content-engine/your-setup/your-offer.md`?
4. **Winnability:** can this user realistically rank or be cited for it? Use the
   difficulty and the type of pages ranking from your keyword tool if it is on, otherwise
   judge from how entrenched the current results are, and say it is a judgment.

Weight intent and funnel stage most heavily. Compute a total. Be honest: discard keywords
that do not fit the user, even popular ones. A focused library beats a scattered one.

## Output

Update `projects/content-engine/content/keyword-ideas.csv` with the four scores and a total, sorted highest first.
Add a short note on the top 3 to 5 and why they lead. Suggest the user run
`/content-engine:blog-pipeline "keyword"` on the top one.

**Conversions:** count only the event named on the "Conversion event" line of `data-sources.md`. If it says "not set", report sessions and engagement and say conversions were not read. Never treat "key events" as sales.
