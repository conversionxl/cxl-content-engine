# Content engine

A content system that runs inside Claude, in four stages: find what to write, create it, keep it current, repurpose it. You give it a topic, a keyword or a published URL, and it works through the steps a senior content team would: research, outline, draft in your voice, fact-check, and a finished article ready to review.

It is the content track's build in CXL's Marketing Engineer cohort, and it works on its own too. You type plain English. You don't need to code.

## What you can do with it

- Find what to write next, from your own search data and from what your audience says in communities and reviews.
- Take a keyword to a publish-ready first draft.
- Refresh articles you have already published.
- Turn a finished article into a carousel (built as slides: one image per slide and a PDF to upload), a newsletter edition (built as a draft in your email tool, with the article's images) or a video script.
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
| `/content-engine:opportunities [topic]` | **Find.** One ranked list of what to write, refresh or fix next, with the command to run for each item |
| `/content-engine:blog-pipeline "your keyword"` | **Create.** New article, from research to a styled preview |
| `/content-engine:update-pipeline "https://your-site.com/article"` | **Refresh.** Updates a published article and shows the new version with changes marked |
| `/content-engine:repurpose "slug or url" carousel video newsletter` | **Repurpose.** A finished article into the formats you name |
| `/content-engine:llms-brand-page` | One page that tells AI answer engines who you are |

Anything you add after the keyword or URL steers the run: angles to take, products to feature, things to avoid.

### The four stages

| Stage | What it reads | What you get |
|---|---|---|
| 1. Find | Your Search Console data (connected, or an export), search questions, Reddit and other communities, review sites, your sales calls and tickets, your competitors' coverage | A ranked list: new article, refresh, title fix or repurpose, each with its evidence |
| 2. Create | The keyword, your setup, live search results, what AI answer engines say | A fact-checked article in your voice, as a styled preview |
| 3. Refresh | A published article | The new version with every change marked |
| 4. Repurpose | A finished article | Carousel copy, a short or long video script, a newsletter edition |

Every stage works on web search alone. Four optional tools make it sharper, and setup talks you through each one:

| Job | Default tool | What it adds |
|---|---|---|
| Keyword and search results data | Ahrefs | Real volume and difficulty, and what competitors rank for that you don't |
| Your own search performance | Google Search Console | Pages that are seen but not clicked, or one push from page one |
| Site analytics | Google Analytics 4 | Which pages turn readers into customers |
| Communities and reviews | A scraper that reads Reddit | Full Reddit and review threads. Firecrawl reads review sites, not Reddit |

Use something else for one of these jobs, such as Semrush or Plausible? Name it in setup and the engine uses that.

## Quality gates

The engine checks its own work at three points, against yes or no checks built from CXL courses. The order is always the same: step, gate, your decision, next step. Each gate says Ready, Needs a look or Needs fixing in plain words, with what to fix and where. Then it stops and asks you to approve, update or stop. A checked piece carries a status line at its top, so you can always tell whether it was edited after its check.

| Gate | When | What it asks |
|---|---|---|
| Strategy | After Find, before anything is written | Does this lead to what you sell? Is the evidence from more than one source? Is a refresh enough? |
| Draft | On the finished article or list post, before the preview (a list post gets its own rows) | Is every claim sourced? Does it say something the top results don't? Is every product fact right? |
| Channel | On each carousel, video script or newsletter | Is every number also in the source article? Is the opening specific to this piece? |

Claude runs the gates. If you have a decision model, Jev (TypeSafe) or Clef (Cloudflare), setup asks whether to switch it on as a second check. It shows where it disagrees with Claude and never approves anything. The checks live in `your-setup/quality-gates.md`: change them, or switch the gates off there.

## Try it on Acme first

Not ready to set up your own brand? The engine ships with **Acme Deals**, a fictional brand that is already set up, with sample articles, customer reviews and a made-up Search Console export. Add `example` as the first word after any command:

```
/content-engine:setup example
/content-engine:opportunities example
/content-engine:blog-pipeline example "white label software for agencies"
/content-engine:repurpose example "buy-once-bill-monthly" carousel newsletter
```

Example runs read and write in `projects/content-engine/example/` only. They never touch your own setup or content.

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

This engine has three sources. **The method is CXL's:** the tactics inside every step come from CXL courses by Andy Crestodina, Gaetano DiNardi, Alex Birkett, Steve Toth and Tarek Reslan, named below. **The stages before and after the article are Tarek Reslan's,** from his CXL courses. **The pipeline structure is Ryan Law's.** It began as a rebuild of the system Ryan Law, Director of Content Marketing at **Ahrefs**, documented in [How I Do Content Engineering with Claude Code](https://ahrefs.com/blog/how-i-do-content-engineering-with-claude-code/) and demoed on the [Ahrefs Podcast](https://www.youtube.com/watch?v=iVZrVeESnFQ) with Tim Soulo. The core structure is his: small skills chained into a pipeline, every step saving its output so you can debug it, a master command that runs them in order, and the idea that you take it and make it yours. Full credit and thanks to Ryan and Ahrefs.

What CXL added to that structure, in four parts:

**1. A guided setup.** Ryan's system assumes you already know your brand, voice and process. This one starts from placeholder files and a setup command that fills them from documents you already have, with a check that stops the engine running until it is yours.

**2. Tactics from four CXL courses.**
- Start **bottom-of-funnel** and put commercial intent ahead of raw search volume.
- Mine **voice of customer** (sales calls, interviews, tickets, reviews) for high-intent topics and buyer language that keyword tools miss.
- Write for **answer engines** (ChatGPT, Perplexity, AI Overviews), not only rankings, so your content gets cited and your brand is described accurately.
- Pass the **"average of the internet" test**: if a reader could get the same article from a one-line prompt, it is not worth publishing.

**3. A focus on B2B marketing.** Every skill leans toward B2B: buyer-journey stages, decision factors (integrations, pricing, compliance, support), comparison content, and a source for every competitor claim.

**4. The stages before and after the article.** Ryan's pipeline starts at a keyword and ends at an article. Two stages were added around it, from **Tarek Reslan's** CXL courses and his two systems ([ai-seo-system](https://github.com/conversionxl/ai-seo-system) and [ai-content-system](https://github.com/conversionxl/ai-content-system)):
- **Find:** five patterns to look for in your Search Console data, trend signals from search questions, communities and reviews, and a title check that reads the live search results first.
- **Repurpose:** a finished article rebuilt as a carousel, a video script or a newsletter edition.
- His fact-check labels and quality checks are folded into the existing claims step, so there is one gate, not two.

The full list is in [docs/how-this-was-made.md](docs/how-this-was-made.md).

## Credits

- **Nick Christensen**, for Acme Deals and its customer data ([ship-icp-ads-automate-monitoring](https://github.com/nickyc1/ship-icp-ads-automate-monitoring), MIT), the example brand.
- **Tarek Reslan**, for the find and repurpose stages, from his CXL courses "Create research-backed and search-optimized content", "Detect trends through reviews and communities" and "Create and repurpose platform-native social content".
- The **CXL courses** the method comes from:
  - [Build optimized B2B content funnels with AI](https://cxl.com/institute/online-courses/b2b-lead-generation-with-ai/), Andy Crestodina
  - [Bottom-of-funnel SEO strategies in tough niches](https://cxl.com/institute/online-course/bottom-of-funnel-seo-strategies-in-tough-niches/), Gaetano DiNardi
  - [Increase visibility and revenue from AI discovery engines](https://cxl.com/institute/live-course/increase-visibility-and-revenue-with-ai-discovery-engines/), Alex Birkett
  - Optimize pages for AI search with GEO, Steve Toth (no longer sold; CXL's current course on the subject is [AI visibility](https://cxl.com/institute/online-course/ai-visibility-brand-monitoring/))
- **Ryan Law** and **Ahrefs**, for the pipeline structure: small skills chained in order, every step saved, one command per pipeline.
