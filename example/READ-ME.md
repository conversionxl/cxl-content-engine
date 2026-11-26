# The Acme Deals example

Acme Deals is a fictional brand. It sells lifetime deals on software to solo agencies and
small marketing teams: pay once, own the tool. This folder is a content engine that is
already set up for Acme, so you can run every command before you set up your own.

Nothing here is real. No real company, customer, search data or article.

## What is in it

| Folder | What it holds | Where it comes from |
|---|---|---|
| `your-setup/` | Acme's brand and voice, its offer, its data sources, two sample articles and one sample newsletter in `voice-examples/` | The voice rules are Nick Christensen's. The offer, the two articles and the newsletter were written for this example |
| `inputs/voice-of-customer/` | Reviews, sales-call notes and support tickets | Nick Christensen's dummy data (MIT, see `LICENSE` in that folder) |
| `inputs/search-console/` | A made-up Search Console export | Written for this example |
| `content/` | Where the example runs save their output. One finished article is in `8-publish/`, ready to repurpose | The article was written for this example |

## Try it

Add `example` as the first word after any command:

```
/content-engine:opportunities example
/content-engine:blog-pipeline example "white label software for agencies"
/content-engine:update-pipeline example "buy-once-bill-monthly"
/content-engine:repurpose example "buy-once-bill-monthly" carousel newsletter
```

Example runs read and write inside this folder only. They never touch your own setup or
your own content.

## Credit

Acme Deals and its customer data come from Nick Christensen's
[ship-icp-ads-automate-monitoring](https://github.com/nickyc1/ship-icp-ads-automate-monitoring)
(MIT). It is the same example brand the Marketing Brain and Campaign Engine use.
