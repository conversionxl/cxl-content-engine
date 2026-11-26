---
name: content-gap-analysis
description: Find keyword and topic opportunities by comparing a site against its competitors. Use to build a list of things worth writing about, saved to keyword-ideas.csv.
---

# Content gap analysis

Find topics the user's audience is searching for that the user has not covered well, or at
all. Output a prioritised list of keyword ideas.

## Inputs

- The user's domain (or topic area).
- A few competitor domains, if the user names them. If not, identify likely competitors
  from who ranks for the user's core topics.

## How to run

**Which tools to use.** Read `projects/content-engine/your-setup/data-sources.md`. A job is
covered when its row is `on`, whatever tool the row names (Ahrefs, Semrush, another). An
older setup file lists tools without jobs: read "Ahrefs MCP" as keyword and search results
data, "Google Search Console MCP" as search performance, "Google Analytics MCP" as site
analytics.

- **Keyword and search results data on:** pull the content gap and keyword opportunities
  directly from that tool. Get volume, parent topic, and difficulty for each idea.
- **Site analytics on:** note which of the user's existing pages bring conversions, so the
  list leans toward topics next to what already pays.
- **Both off (default):** do it with built-in web search. Search the user's core topics,
  see who ranks, scan those competitors for sections and subtopics, and note recurring
  themes the user is missing. Mark any volume figures as estimates, not measured data.

## Feasibility gate (run this first)

Before listing ideas, sanity-check that search content is even the right play, the way a
B2B SEO strategist would. Two questions:

1. **Is there real search demand?** If the topic is so new or niche that nobody searches it
   yet, you would be creating demand, not capturing it. That is a job for social, video, or
   outbound, not SEO. Flag it and move on.
2. **Is there product-market fit to convert?** If the user is still testing whether the
   offer converts, SEO is a slow bet. Note the risk.

If either fails, say so plainly rather than padding the list with topics that will not pay
off. A short, winnable list beats a long, hopeful one.

## Steps

1. Establish the user's core topics from `projects/content-engine/your-setup/brand-and-voice.md` and `your-offer.md`.
2. Find what competitors rank for that the user does not.
3. Group ideas into themes so the list is not just scattered keywords.
4. **Down-weight generic top-of-funnel "corporate wikipedia" topics.** Broad definitional
   posts ("what is a KPI") are exactly the content type that AI Overviews and answer engines
   have hit hardest. For a B2B audience, favour specific, decision-stage topics tied to the
   user's offer over high-volume generic explainers. Mark each idea's likely funnel stage.
5. For each idea note: the keyword, the theme, the funnel stage, why it fits this user, and
   (if available) volume and difficulty.

## Output

Write or append to `projects/content-engine/content/keyword-ideas.csv` with columns:
`keyword, theme, funnel_stage, rationale, est_volume, difficulty, source`

Tell the user how many ideas you added, which themes look strongest, and flag any that
failed the feasibility gate. Suggest running `keyword-prioritization` next.
