# Data sources

Example setup for Acme Deals, a fictional brand.

## Toggles

| Source | Status | Used for |
|---|---|---|
| Built-in web (search + fetch) | on | Always available. SERP scans, competitor pages, research. |
| Ahrefs MCP | off | Keyword volume, parent topic, related terms, SERP data |
| Google Search Console MCP | off | Your real queries, impressions, positions |
| Google Analytics MCP | off | Traffic and conversion data for your pages |
| Web scraper (Apify, Firecrawl or similar) | off | Full Reddit threads and review pages for `trend-signals` |

Search Console is off on purpose. The example reads the made-up export in
`inputs/search-console/acme-search-console.csv` instead, so everyone gets the same numbers.
Every figure from that file is dummy data and is labelled that way in the output.
