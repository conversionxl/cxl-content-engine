---
name: trend-signals
description: Find what your audience is asking, struggling with and arguing about right now, from search questions, Reddit and other communities, and review sites. Returns recurring pain points and ranked content ideas in the audience's own words. Use when deciding what to write, or to find an angle for a topic.
---

# Trend signals

Find topics from what people are doing, not from a brainstorm. Three sources, one output:
the questions people search, the conversations they have in communities, and what they write
in reviews.

## Input

A topic or keyword from the user. If none is given, take the main topics from
`projects/content-engine/your-setup/brand-and-voice.md` and the category in `your-offer.md`,
and confirm them in one line before starting.

## Tools

Built-in web search and fetch are enough. If a scraper is marked `on` in
`projects/content-engine/your-setup/data-sources.md` (Apify, Firecrawl or similar), use it
for Reddit and review pages, because it returns full threads and comments. If a page cannot
be read, say so and move on. Never invent a quote, a thread or a review.

## Step 1: search questions

Search the topic and collect:

- the "People also ask" questions
- the related searches
- the modifiers that keep appearing ("for B2B", "vs", "template", "without", a year)
- the angles the top results all share, and the one none of them takes

Look for repeated questions, beginner confusion, tactical "how do I" problems and open
disagreements.

## Step 2: communities

**Pick 3 to 5 communities where practitioners discuss the topic.** A site-wide Reddit search
returns popular off-topic posts, not practitioner discussions, so search inside each
subreddit:

```
https://www.reddit.com/r/SUBREDDIT/search/?q=QUERY&sort=top&t=month&restrict_sr=1
```

Starting points for marketing topics:

| Topic area | Subreddits |
|---|---|
| AI marketing, AI tools | r/marketing, r/digitalmarketing, r/artificial, r/ChatGPT |
| B2B marketing, demand generation | r/marketing, r/b2bmarketing, r/sales |
| SEO, content | r/SEO, r/bigseo, r/content_marketing |
| Marketing automation | r/marketing, r/marketingautomation, r/nocode |
| Paid ads | r/PPC, r/FacebookAds, r/marketing |
| Startups, growth | r/startups, r/Entrepreneur, r/GrowthHacking |
| Automation tools | r/nocode, r/n8n, r/zapier, r/automation |

For another field, ask: where do people with this job gather, and which communities cover
the tools they use? Slack and Discord communities, LinkedIn comment threads and niche forums
count too, when the user can paste or export them.

From each community, pull recurring questions, frustrations, requests for help, debates and
misconceptions, with the thread link. Keep the exact wording. Do not summarise a thread into
your own words: the phrasing is the value.

## Step 3: reviews

Read reviews of the user's product category on the review sites that cover it (G2, Capterra,
TrustRadius, app stores, Trustpilot): the user's own product and two or three competitors
from `your-offer.md`.

Collect, with the link:

- what people praise in their own words
- what they complain about, and how often
- why they switched from one product to another
- what they were trying to get done when they bought

Complaints about a competitor are topics. Reasons for switching are angles. A claim about a
competitor in a later article still needs its source link, so keep it here.

## Step 4: find the patterns

One loud thread is not a trend. Keep a signal only when it shows up in at least two places:
two communities, or a search question and a review theme. Group what is left into themes
(beginner mistakes, tactical how-tos, myths, tool comparisons, open debates).

## Output

Write `projects/content-engine/content/opportunities/trends-{topic-slug}-{YYYY-MM-DD}.md`:

1. **Recurring pain points:** each with two or more source links and one verbatim quote.
2. **Content ideas, ranked:** the idea, the angle, why it matters now, the sources behind it,
   and the best format (article, refresh of an existing page, carousel, short video,
   newsletter). Rank by how often the signal recurs and how close it sits to what the user
   sells.
3. **Themes** that could each carry several pieces.
4. **Sources read,** and any that could not be read.

For the top article ideas, give the command to run next:
`/content-engine:blog-pipeline "idea" [the angle and the quotes to use]`.

Community and review quotes are public, but leave out usernames and anything that identifies
a private person. Never use em dashes.

Credit: the three-source method and the subreddit search pattern come from Tarek Reslan's
content ideation skill and his CXL course "Detect trends through reviews and communities".
