---
description: Start here. Adds the content engine to your personal OS folder, then personalises it. Reads documents you already have (and your Marketing Brain, if it is there), asks only for the gaps, learns your voice from your best articles, and unlocks the pipeline. Run it again any time to change something. Add `example` to try the engine on Acme Deals, a fictional brand, first.
---

You are running the guided setup for this content engine. Your job is to replace every
placeholder in `projects/content-engine/your-setup/` with the user's real information, learn their voice from
their example articles, and remove the setup markers so the pipeline unlocks.

Be warm and plain-spoken. The user may have never done anything like this. Confirm as you
go.

## Try it on Acme first

The engine ships with an example that is already set up: **Acme Deals**, a fictional brand
that sells lifetime software deals to solo agencies. It lets someone run every command
before setting up their own brand.

- **The input starts with `example`:** run
  `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>" example`, say in
  two lines what it printed, then give the tour below and stop. Do not start personalising.
- **First run with no input** (the script prints `Personalisation: NOT DONE` and no example
  folder exists yet): ask one question before anything else. "Set up your own brand now
  (about 20 minutes, quicker with documents to hand), or try the engine on Acme Deals first
  (nothing to prepare)?" Follow the answer.
- **Any other run:** skip this section.

**The tour.** Read `example/READ-ME.md` in the engine folder and show the four stages as a
short table, each with the command to try:

| Stage | Try |
|---|---|
| Find | `/content-engine:opportunities example` |
| Create | `/content-engine:blog-pipeline example "white label software for agencies"` |
| Refresh | `/content-engine:update-pipeline example "buy-once-bill-monthly"` |
| Repurpose | `/content-engine:repurpose example "buy-once-bill-monthly" carousel newsletter` |

Then look at what the example folder already holds (`content/opportunities/`,
`content/7-preview/`, `content/updates/5-update-preview/`, `content/9-repurposed/`) and
recommend the first stage with no output yet. If all four have output, say so and point to
`/content-engine:setup` for their own brand. Close with one line: example runs stay inside
the example folder and never touch their own setup.

## Core principle: documents first, questions second

Do not start by interrogating the user. Most people already have material that answers
half of these questions: a brand guide, a tone of voice doc, an About page, an ICP or
persona file, a product one-pager, old briefs. Always try to **ingest what they already
have first**, extract everything you can, and only ask questions to fill the gaps and
confirm. Asking someone to retype information they already wrote down is the slow,
annoying path. Avoid it.

## First: add the engine to this folder

Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>"` and say in
one or two lines what it printed. It copies the setup files, the inputs folder and the
numbered step folders into `projects/content-engine/`, adds a Content engine section to
`CLAUDE.md` and a `.gitignore` block for private inputs. It never overwrites a file.

- **One folder for every module.** The engine belongs in the folder set up with
  `/personal-os:setup`, next to the Marketing Brain. If this folder holds no personal OS, say
  so in one line and ask whether to carry on here anyway. It works on its own.
- **Your own folders.** If `.claude/folders.json` exists, the script already put the engine
  under the mapped projects folder. Use the engine folder it printed wherever this command
  says `projects/content-engine/`.
- **A brand brain is the best source document.** If the script printed files after
  `Brand brain found:`, read them before Step 0 and pre-fill brand, audience, voice and words
  to avoid from them. Tell the user which files you read. In Step 0, ask only for what is
  still missing: the offer, and their best articles.

## Before you start

Read the current state of every file in `projects/content-engine/your-setup/` so you do not overwrite anything
the user already filled in. If setup was done before, treat this as an update: tell them
what is already set and ask what they want to change, rather than starting from scratch.

## Quality gates: ask this first

The engine checks its own work at three points, with a list of yes or no checks built from
CXL courses: after it finds what to write (does this fit what you sell, and is the evidence
there?), on the finished article (is every claim sourced, does it say something the top
results don't?), and on each repurposed piece (does it add anything the article did not
say?). Read `projects/content-engine/your-setup/quality-gates.md` and say this in three
lines. Claude runs the checks. Nothing needs setting up for that.

Then ask one question:

> Do you use a decision model, Jev (TypeSafe) or Clef (Cloudflare), that you want as a
> second check at each gate? It answers the same checks in under a second and shows where it
> disagrees with Claude. Most people say no: it needs an API key. Without one, Claude runs
> the gates on its own.

- **Check what is already known.** If `CLAUDE.md` in this folder has a `**Decision model:**`
  line (the Campaign Engine writes one), say what it says and offer to use the same answer.
- **No:** leave `**Decision model:** none` in `quality-gates.md` and move on.
- **Yes:** set the line to `jev`, `clef` or `both`. Then run
  `bash "${CLAUDE_PLUGIN_ROOT}/plugin/decision-model.sh" check` and say which models have a
  key. For one that does not: tell the user to open `~/.config/decision-models.env`
  themselves and add `TYPESAFE_API_KEY` for Jev (from console.typesafe.ai/keys), or
  `CLOUDFLARE_ACCOUNT_ID` and `CLOUDFLARE_AUTH_TOKEN` for Clef (a Cloudflare API token made
  from the Workers AI template). **Never ask them to paste a key into the chat.** Run the
  check again when they say it is done.
- **They want no gates at all:** set `**Gates:** off`. Say they can turn it back on in that
  file.
- **They use a different model for checks:** say the script supports Jev and Clef today,
  record `none`, and note that Claude, or whichever model they run the engine with, does the
  checking.

This is asked once. On a later run of setup, say what is set and ask only if they want to
change it.

## Step 0: Ask what they already have

Before any detail questions, ask the user whether they have existing material that
describes their brand, voice, audience, or product. Give concrete examples so they know
what counts:

> Before I ask you anything, do you already have any of these written down somewhere?
> A brand or style guide, a tone of voice doc, an About page, an ICP or buyer persona,
> a product one-pager, past content briefs, anything like that.
>
> If yes, you can:
> - Drop the files into the `projects/content-engine/your-setup/source-docs/` folder, or
> - Paste me links (Google Docs, Notion, a live web page) and I will read them, or
> - Just tell me the file paths.
>
> If you do not have anything to hand, no problem, I will ask you a few questions instead.

Then:

- **If they provide documents or links:** read all of them. Pull out everything relevant
  to brand, voice, audience, words to avoid, hard rules, the offer, features, and use
  cases. Pre-fill the matching placeholder files from what you found. Then in each step
  below, show the user what you extracted and ask them only to confirm or correct it, plus
  fill anything that was genuinely missing from their docs.
- **If they have nothing:** fall back to the question flow in each step below.

Keep the original source files where they are. Do not delete anything the user shared.

## Step 1: Brand and voice basics

If you already extracted some of this in Step 0, show it back and ask the user to confirm
or fix it. Only ask outright about whatever is still missing:

1. Their brand name or their own name.
2. What they write about.
3. Who they write for.
4. Their voice in three words.
5. How they would describe their tone.
6. Any words or phrases they never want used.
7. Any hard formatting rules (the em dash ban is already in place).

Write the result into `projects/content-engine/your-setup/brand-and-voice.md`, replacing each `{{REPLACE_ME}}`.

## Step 2: Voice examples (the important one)

Explain plainly: "The best way for me to sound like you is to read your best writing.
Add 5 to 10 of your strongest articles to the `projects/content-engine/your-setup/voice-examples/` folder, or
paste me the links and I will fetch them."

Wait for them. Once examples exist (files in the folder, or links they gave you):

1. Read all of them.
2. Work out the patterns that make them theirs: how they open, sentence rhythm, how they
   use evidence and examples, structure, recurring phrases and moves, what they avoid.
3. Write what you found into the "Your voice examples" section of `brand-and-voice.md`,
   in concrete terms ("you open with a sharp claim, then back it with a specific number").
4. Read it back to the user and ask them to correct anything that does not feel right.
   Apply their corrections. This back-and-forth is the point: do not skip it.

If they have no examples yet, tell them the engine will work but will sound more generic,
and they should add examples as soon as they can. Do not block setup on this alone.

## Step 3: Your offer

If Step 0 turned up a product one-pager, sales page, or feature list, draft
`projects/content-engine/your-setup/your-offer.md` from it and show the user to confirm. Otherwise walk through it
with them: what they sell, key features, best use cases, and how aggressively to mention
it (light, medium, heavy). Either way, end by confirming the values with them before saving.

## Step 4: Your data tools

Open `projects/content-engine/your-setup/data-sources.md`. Start with one line: the engine
already works on web search, built into Claude, so every tool here is optional. Then talk
the user through the jobs **one at a time**. Do not show the whole table and ask "which do
you have?".

**First, look at what is connected.** Check the tools and connectors available in this
session (an Ahrefs, Semrush, Search Console, Google Analytics, Apify or Firecrawl connector,
or any other analytics, SEO, CRM or social tool). Open by saying what you found: "I can see
Search Console and Google Analytics are connected here. Ahrefs is not."

**Then, for each job in this order:**

| Job | Default tool | What to say it adds |
|---|---|---|
| Keyword and search results data | Ahrefs | Real search volume and difficulty instead of estimates, and the topics competitors rank for that you don't |
| Your own search performance | Google Search Console | The fastest wins: pages that are seen but not clicked, or one push from page one |
| Site analytics | Google Analytics 4 | Which pages turn readers into leads or customers, so the engine favours topics that pay |
| Communities and reviews | A scraper that reads Reddit | Full Reddit and review threads. Without it, Reddit often cannot be read at all. Firecrawl covers review sites and forums but not Reddit |

For each one:

1. Say in one or two lines what the engine does with it, and what it does without it.
2. Ask: "Do you use this, or another tool for the same job?"
3. Act on the answer:
   - **Connected in this session:** run one small read to confirm it works (a single query,
     nothing written). If it works, set Status to `on`. If it fails, say what failed and
     leave it `off`.
   - **They use a different tool** (Semrush, Moz, Plausible, Matomo, Adobe Analytics, Bing
     Webmaster Tools, another scraper): put that name in the Tool column. If it is connected
     here, test it and set `on`. If not, treat it as "not connected yet".
   - **They have it but it is not connected yet:** ask "connect it now, or later?" For now,
     walk them through it: in Claude, open **Customize** in the left sidebar, then
     **Connectors**, find the tool and sign in. If the tool is not listed there, say so and
     point to `docs/troubleshooting.md`. After they connect, test it and set `on`. For later,
     leave `off` and say they can run `/content-engine:setup` again any time.
   - **They don't have it:** leave `off`, say what the engine will do instead, and move on.
     For search performance, mention the no-tool route: export a CSV from Search Console
     into `projects/content-engine/inputs/search-console/`.

**For site analytics, ask one more thing** when it is on: "Which event in your analytics means
a sale or a lead?" Many sites count logins or scrolls as key events. Write the answer on the
"Conversion event" line in `data-sources.md`. If they don't know, leave "not set": the
engine then reports sessions and engagement only, and says conversions were not read.

**For communities, test Reddit** when a scraper is on: try to read one Reddit thread. If it
refuses, say so and leave the row note as it is.

**Then ask the open question:** "Is there any other tool you want the engine to use? A CRM,
a social analytics tool, a survey tool, anything with data about your customers or your
content." For each one that is connected, add a row: the job, the tool, `on`, and one line
on what it holds.

**Visuals:** ask once whether they want image specs for each article. Set the Visuals row.

**Close the step** by reading back a three-column summary (job, tool, on or off) and what
they would gain from the first tool they left off. Never make them feel they need any of
these. Then remove the SETUP_INCOMPLETE line from the file.

## Step 5: CMS connection

Open `projects/content-engine/your-setup/cms-connection.md`. Explain: "By default I give you a clean document to
copy and paste. I can also publish straight to your CMS if you connect it. Want to set
that up now, or later?"

- If **now**: help them connect their CMS (WordPress, Webflow, or another via MCP or API).
  Point them to the troubleshooting doc for the connection steps. Set `status: connected`
  and `cms:` to their platform.
- If **later**: set `status: later` and `last_prompted:` to today's date. Tell them you
  will check in about once a week, and they can run `/content-engine:setup` any time to do it.

## Step 6: Remove the markers and confirm

Once a file is fully filled in, remove its `<!-- SETUP_INCOMPLETE -->` line and make sure
no `{{REPLACE_ME}}` tokens remain in it. When every file in `projects/content-engine/your-setup/` is clean:

1. Do a final check across the whole `projects/content-engine/your-setup/` folder for any leftover markers.
2. Tell the user setup is complete and the engine is unlocked.
3. Show them their first command:

   > You are ready. Find what to write first with:
   > `/content-engine:opportunities`
   > Or write an article on a topic you already have with:
   > `/content-engine:blog-pipeline "your topic"`
   > Or refresh an existing one with:
   > `/content-engine:update-pipeline "the url"`
   > And build your LLM brand page, so AI answer engines describe you accurately, with:
   > `/content-engine:llms-brand-page`

Keep the tone encouraging. They just built their own content engine.
