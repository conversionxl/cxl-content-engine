# Content engine

A content writing system that runs inside Claude. You give it a keyword or a published URL, and it works through the steps a senior content team would: research, outline, draft in your voice, fact-check, and a finished article ready to review.

It is the content track's build in CXL's Marketing Engineer cohort, and it works on its own too. You type plain English. You don't need to code.

## What you can do with it

- Take a keyword to a publish-ready first draft.
- Refresh articles you have already published.
- Make every article sound like **you**, by teaching it from your own best writing.
- See every step of the work, so you can fix the one part that went wrong without starting over.

## Install the plugin (recommended)

1. Open Claude: claude.ai or the desktop app ([claude.ai/download](https://claude.ai/download)).
2. Open **Settings → Plugins**, click **Add → Add marketplace**, and choose the GitHub repo option.
3. Enter `conversionxl/cxl-content-engine`, then add **Content engine**.
4. Open your personal OS folder in the desktop app's **Code** tab, with **Environment** set to **Local**. No personal OS yet? Add the [Personal OS plugin](https://github.com/conversionxl/cxl-personal-os-plugins) first, or use any empty folder: the engine works on its own.
5. Type `/content-engine:setup`.

Install it one way only. The plugin is saved to your Claude account, so you add it once.

**Can't add a marketplace?** Download [content-engine.zip](https://github.com/conversionxl/cxl-content-engine/releases/download/plugin-zips/content-engine.zip) and upload it in **Settings → Plugins → Upload**. Don't unzip it, and don't use the green **Code → Download ZIP** button for this: that file fails the upload check.

## The one rule: set it up first

The engine ships with **placeholder** brand, voice and product information. It will not write until those are yours. You don't edit files by hand. You run one command and it does the work:

```
/content-engine:setup
```

Setup adds a `projects/content-engine/` folder to your folder, then asks for documents you already have (a brand guide, an ICP, a product one-pager) and only asks questions for the gaps. If the Marketing Brain is in the same folder, it reads your brand brain first. It never overwrites a file. Run it again any time to change something.

## Commands

| Command | What it does |
|---|---|
| `/content-engine:setup` | Adds the engine to your folder and personalises it |
| `/content-engine:blog-pipeline "your keyword"` | New article, from research to a styled preview |
| `/content-engine:update-pipeline "https://your-site.com/article"` | Refreshes a published article and shows the new version with changes marked |
| `/content-engine:llms-brand-page` | One page that tells AI answer engines who you are |

Anything you add after the keyword or URL steers the run: angles to take, products to feature, things to avoid.

## Where your work goes

| Folder | What is in it |
|---|---|
| `projects/content-engine/your-setup/` | Your brand and voice, your offer, your data sources, your best articles |
| `projects/content-engine/inputs/` | Keywords, and voice-of-customer material (kept on your machine) |
| `projects/content-engine/content/` | One numbered folder per step, one file per article |

Already use your own folder names? The engine follows the folder map your personal OS saved in `.claude/folders.json`.

## Download and customize (advanced)

The plugin is a working example of a full build, and a base to copy from. If you want to change how the engine works and make it your own, download this repository and edit it:

- Every step is one small file: `skills/<step>/SKILL.md`.
- The pipelines that chain the steps are in `commands/`.
- The files setup copies into your folder are in `template/`.

Rename skills, add steps, remove the parts you don't use. Then point Claude at your copy: in a terminal session, `/plugin marketplace add <path to your copy>`. If you customize, use your copy only. Two copies installed side by side list every command twice.

## Learn how it works

- [docs/how-it-works.md](docs/how-it-works.md) explains the thinking behind the system.
- [docs/customise-your-voice.md](docs/customise-your-voice.md) shows how to make it sound like you.
- [docs/troubleshooting.md](docs/troubleshooting.md) covers common snags.

## How this engine was built

This engine began as a rebuild of the system **Ryan Law**, Director of Content Marketing at **Ahrefs**, documented in [How I Do Content Engineering with Claude Code](https://ahrefs.com/blog/how-i-do-content-engineering-with-claude-code/) and demoed on the [Ahrefs Podcast](https://www.youtube.com/watch?v=iVZrVeESnFQ) with Tim Soulo. The core structure is his: small skills chained into a pipeline, every step saving its output so you can debug it, a master command that runs them in order, and the idea that you take it and make it yours. Full credit and thanks to Ryan and Ahrefs.

We then made three sets of changes:

**1. A guided setup.** Ryan's system assumes you already know your brand, voice and process. This one starts from placeholder files and a setup command that fills them from documents you already have, with a check that stops the engine running until it is yours.

**2. Tactics from four CXL courses.**
- Start **bottom-of-funnel** and put commercial intent ahead of raw search volume.
- Mine **voice of customer** (sales calls, interviews, tickets, reviews) for high-intent topics and buyer language that keyword tools miss.
- Write for **answer engines** (ChatGPT, Perplexity, AI Overviews), not only rankings, so your content gets cited and your brand is described accurately.
- Pass the **"average of the internet" test**: if a reader could get the same article from a one-line prompt, it is not worth publishing.

**3. A focus on B2B marketing.** Every skill leans toward B2B: buyer-journey stages, decision factors (integrations, pricing, compliance, support), comparison content, and a source for every competitor claim.

The full list is in [docs/how-this-was-made.md](docs/how-this-was-made.md).

## Credits

- **Ryan Law** and **Ahrefs**, for the content engineering approach this is built on.
- The **CXL courses** these tactics come from:
  - [Build optimized B2B content funnels with AI](https://cxl.com/institute/online-courses/b2b-lead-generation-with-ai/), Andy Crestodina
  - [Bottom-of-funnel SEO strategies in tough niches](https://cxl.com/institute/online-course/bottom-of-funnel-seo-strategies-in-tough-niches/), Gaetano DiNardi
  - [Increase visibility and revenue from AI discovery engines](https://cxl.com/institute/live-course/increase-visibility-and-revenue-with-ai-discovery-engines/), Alex Birkett
  - [Optimize pages for AI search with GEO](https://cxl.com/institute/online-courses/optimize-pages-for-ai-search-with-aeo-cohort/), Steve Toth
