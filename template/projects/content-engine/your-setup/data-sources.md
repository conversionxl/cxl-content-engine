<!-- SETUP_INCOMPLETE -->
# Data sources

The engine works out of the box on **web search and page reading, built into Claude**. No
setup needed. Every other tool below is optional: connect the ones you have, and the engine
uses them for that job and stops estimating.

`/content-engine:setup` talks you through each one. To change something later, run it again
or edit this file by hand.

## Your tools

| Job | Tool | Status | What the engine does with it |
|---|---|---|---|
| Web search and page reading | Built into Claude | on | Always available. Search results, competitor pages, research, sources for claims. |
| Keyword and search results data | Ahrefs | off | Search volume, difficulty, parent topic, what ranks, what competitors rank for that you don't. Used to find topics, score them, research an article and check a title. |
| Your own search performance | Google Search Console | off | Your real queries, clicks, impressions and positions. Used to find pages that are seen but not clicked, close to page one, or losing ground. |
| Site analytics | Google Analytics 4 | off | Sessions, engagement and conversions per page. Used to tell a page that wins the click from a page that wins the customer, and to pick which topics to favour. |
| Communities and reviews | Apify or Firecrawl | off | Full Reddit threads, forum threads and review pages. Used to find what your audience asks and complains about, in their own words. |
| Visuals | none | off | Image specs for an article. Switch on only if you want them. |

**Using a different tool for one of these jobs?** Put its name in the Tool column of that
row: Semrush or Moz instead of Ahrefs, Plausible, Matomo or Adobe Analytics instead of Google
Analytics, Bing Webmaster Tools next to Search Console. The engine goes by the job, so it
uses whatever tool you name there, as long as it is connected to Claude.

**Have a tool for a job that is not listed?** Add a row: the job, the tool, `on`, and one
line on what it holds (a CRM with deal data, a social analytics tool, a survey tool).

**Rules the engine follows:**

- A tool is used only when its Status is `on` and it is connected to Claude in this session.
- With a tool `off`, the engine uses web search for that job and says when a number is an
  estimate, or leaves it blank. It never invents a metric.
- No connected tool? An export works too. Drop a CSV in the matching `inputs/` folder
  (`inputs/search-console/` for search performance) and the engine reads that.

Run `/content-engine:setup` to confirm these, or edit them by hand and delete the SETUP_INCOMPLETE line.
