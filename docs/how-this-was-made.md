# How this was made

This document records where the engine came from and what we changed, so you know exactly
what you are running and why.

## The foundation: Ryan Law and Ahrefs

The structure of this repo is based on the content-engineering system built by **Ryan Law**,
Director of Content Marketing at **Ahrefs**. He shared it in two places:

- Blog post: [How I Do Content Engineering with Claude Code](https://ahrefs.com/blog/how-i-do-content-engineering-with-claude-code/)
- Demo on the [Ahrefs Podcast](https://www.youtube.com/watch?v=iVZrVeESnFQ) with Tim Soulo

From his work we kept the core ideas: chaining small single-purpose skills, saving the output
of every step so you can debug the one that failed, a master pipeline command, front-loaded
human direction, a readable HTML preview, and the principle that you fork and personalise the
whole thing. Thank you to Ryan and Ahrefs.

## What we changed

### 1. Setup and onboarding, rebuilt for first-timers

Ryan built his repo for himself. This one is built to hand to someone who has never used
GitHub, VS Code, or Claude Code.

- **A plugin, since November 2026.** The first version was a repository you downloaded, with
  click-by-click install guides. It now installs from Settings, Plugins, and sets itself up
  inside your personal OS folder. Downloading the repository is still open to you, as the
  route for people who want to change how the engine works.
- **The `projects/content-engine/your-setup/` folder with placeholder context files:** `brand-and-voice.md`,
  `your-offer.md`, `data-sources.md`, and `cms-connection.md` ship with `{{REPLACE_ME}}`
  placeholders and a clear read-me explaining what a placeholder is.
- **A setup gate:** the engine refuses to run the pipelines until those placeholders are
  filled, so nobody accidentally publishes in a generic or borrowed voice.
- **The `/content-engine:setup` command:** an interview that fills the placeholders for you. It leads with
  "what documents do you already have?" (brand guide, ICP, product one-pager, past briefs),
  ingests those from `projects/content-engine/your-setup/source-docs/`, and only asks questions for what is missing.
- **Voice learned from examples:** you drop your best articles into `projects/content-engine/your-setup/voice-examples/`
  and the engine infers what makes them yours, rather than asking you to describe your own voice.

### 2. Tactics from four CXL courses

We read the courses and folded their strongest ideas into the skills:

- [Build optimized B2B content funnels with AI](https://cxl.com/institute/online-courses/b2b-lead-generation-with-ai/)
  (Andy Crestodina): the "average of the internet" quality test, better inputs beat better
  prompts, and differentiating with proprietary data and point of view.
- [Bottom-of-funnel SEO strategies in tough niches](https://cxl.com/institute/online-course/bottom-of-funnel-seo-strategies-in-tough-niches/)
  (Gaetano DiNardi): start bottom-of-funnel, prioritise commercial intent over volume, mine
  paid-search and sales calls, and source every competitor claim.
- [Increase visibility and revenue from AI discovery engines](https://cxl.com/institute/live-course/increase-visibility-and-revenue-with-ai-discovery-engines/)
  (Alex Birkett): "search everywhere optimisation", measuring beyond traffic, and that brand
  mentions and citations drive inclusion in AI answers.
- [Optimize pages for AI search with GEO](https://cxl.com/institute/online-courses/optimize-pages-for-ai-search-with-aeo-cohort/)
  (Steve Toth): structure content so answer engines can cite it, shape how LLMs describe your
  brand, and keep that description accurate (truth alignment).

These show up as upgrades across nearly every skill, plus three new pieces.

### 3. New skills and commands

- **`voice-of-customer-mining`** (skill): turns sales calls, customer interviews, win/loss
  calls, support tickets, surveys, and reviews from `projects/content-engine/inputs/voice-of-customer/` into
  high-intent topics and real buyer language. Runs first in `/content-engine:blog-pipeline` when material
  is present, and nudges you to add some when it is not.
- **`answer-engine-audit`** (skill): checks what ChatGPT, Perplexity, and AI Overviews say
  about a topic or your brand, and who they cite. Runs in both pipelines and feeds the brand
  page.
- **`/content-engine:llms-brand-page`** (command): generates an LLM-readable brand page so answer engines
  describe you accurately. It reuses `your-reference`, `answer-engine-audit`, and
  `verify-claims` rather than duplicating them.

### 4. Reliability and focus

- Both pipeline commands now explicitly **invoke each skill with the Skill tool** rather than
  improvising the step, so the chain runs the real, current skill files every time.
- Every skill is **biased toward B2B marketing:** buyer-journey stages, decision factors, and
  comparison content.

### 5. The stages before and after the article (0.2.0, November 2026)

Tarek Reslan taught three CXL courses on a second pair of systems, `ai-seo-system` and
`ai-content-system`. Running two methods for one job confused people, so his material was
folded into this engine where it covered ground the pipeline did not:

- **`/content-engine:opportunities`** (command) and the skills **`search-console-opportunities`**,
  **`trend-signals`** and **`title-and-meta`**: find what to write from your own search data,
  from communities and from reviews, before a keyword is chosen.
- **`/content-engine:repurpose`** (command) and the skills **`repurpose-carousel`**,
  **`repurpose-video`** and **`repurpose-newsletter`**: rebuild a finished article for other
  platforms.
- **`update-guidance`** now reads the page's own search data first, so a refresh starts from
  the right fix: the title, the depth, or a missing section.
- **`verify-claims`** gained his claim labels and six quality checks, so there is still one
  gate before the preview.

What was left out, on purpose: his project-management, reporting, technical SEO, social
analytics and content calendar skills (not content creation), his second article writer and
optimizer (the pipeline already does that job), and example hooks that could sit on any
post. Measuring how often AI names you is the AI visibility builds, not this engine.

### 6. An example you can run before setup (0.3.0)

Setup takes about 20 minutes and needs your own material. The engine now ships with **Acme
Deals**, Nick Christensen's fictional brand (MIT), already set up: voice rules, an offer, two
sample articles, customer reviews and call notes, and a made-up Search Console export. Add
`example` to any command and it runs there, in its own folder.

### 7. Quality gates (0.5.0)

Three gates, following the design of CXL's Campaign Engine: one yes or no statement per row,
a few must-pass rows, and a decision model (Jev or Clef) as an optional second opinion that
never approves anything. The rows come from the same courses as the tactics: Gaetano DiNardi
(does it lead to the offer, is every competitor claim sourced), Andy Crestodina (does it say
something the top results don't), Steve Toth (headers as questions, product facts that match),
Alex Birkett (how it earns a citation), Tarek Reslan (intent, usefulness, the repurposing
rows) and Ryan Law (verify claims).

## The result

Same dependable structure Ryan designed, with a gentle on-ramp for new users, proven B2B
tactics built in, and explicit attention to how content performs in AI answer engines.
