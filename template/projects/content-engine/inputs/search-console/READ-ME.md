# Drop a Search Console export here

Only needed if Search Console is not connected to Claude. With it connected (and switched
`on` in `your-setup/data-sources.md`), the engine reads your data directly.

## How to export

1. Open [Google Search Console](https://search.google.com/search-console) and pick your site.
2. Open **Performance → Search results**.
3. Set the date range to the last 3 months, and switch on clicks, impressions, CTR and
   average position.
4. Click **Export** and choose CSV. Drop the files in this folder.

## How it's used

`/content-engine:opportunities` reads the export to find pages that are seen but not
clicked, pages close to page one, pages losing ground, and queries that have no page of
their own.
