# Data sources

Example setup for Acme Deals, a fictional brand. Every optional tool is off, so everyone gets the same result.

## Your tools

| Job | Tool | Status | What the engine does with it |
|---|---|---|---|
| Web search and page reading | Built into Claude | on | Always available. Search results, competitor pages, research, sources for claims. |
| Keyword and search results data | Ahrefs | off | Search volume, difficulty, parent topic, what ranks, what competitors rank for that you don't. Used to find topics, score them, research an article and check a title. |
| Your own search performance | Google Search Console | off | Your real queries, clicks, impressions and positions. Used to find pages that are seen but not clicked, close to page one, or losing ground. |
| Site analytics | Google Analytics 4 | off | Sessions, engagement and conversions per page. Used to tell a page that wins the click from a page that wins the customer, and to pick which topics to favour. |
| Communities and reviews | A scraper that reads Reddit | off | Full Reddit threads, forum threads and review pages. Firecrawl reads review sites and forums but refuses Reddit (checked 26 Nov 2026). Used to find what your audience asks and complains about, in their own words. |
| Visuals | none | off | Image specs for an article. Switch on only if you want them. |

Search performance is off on purpose. The example reads the made-up export in
`inputs/search-console/acme-search-console.csv` instead. Every figure from that file is
dummy data and is labelled that way in the output.
