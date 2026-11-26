---
description: Find what to write or update next. Reads your Search Console data, what your audience asks in search, communities and reviews, your customers' own words and your competitors' coverage, and returns one ranked list with the command to run for each item. Usage: /content-engine:opportunities [topic or notes]
argument-hint: [topic to focus on, or notes]
---

Find the next pieces worth making for: **$ARGUMENTS**

## First, check the setup

Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>"`. It never
overwrites a file, and prints where the engine folder is and whether personalisation is done.

- If it prints `Personalisation: NOT DONE`, STOP. Tell the user to run `/content-engine:setup`
  first, and why: the engine will not rank topics against placeholder brand data. Do not continue.
- If `.claude/folders.json` exists, every `projects/content-engine/...` path in this command and
  in the skills it invokes is read and written under the engine folder the script printed.

## Parse the input

- Anything the user typed is the **topic or steering**: a topic to focus on, a product to
  favour, things to leave out.
- With no input, use the main topics in `projects/content-engine/your-setup/brand-and-voice.md`.

## Say what will run

Before starting, tell the user in a short list which of the four sources below will run and
which will be skipped, with the reason (Search Console not connected and no export, no
voice-of-customer files). Then start. Do not wait for an answer.

## Run these skills, saving each output

For each step, **invoke the named skill with the Skill tool** (each is listed as
`content-engine:<name>`). Do not perform the step from memory. Never skip the saves.

1. **search-console-opportunities** (only if Search Console is `on` in `data-sources.md`, or
   an export is in `projects/content-engine/inputs/search-console/`)
   -> `projects/content-engine/content/opportunities/search-console-{date}.md`
2. **trend-signals** (search questions, communities, reviews)
   -> `projects/content-engine/content/opportunities/trends-{topic-slug}-{date}.md`
3. **voice-of-customer-mining** (only if `projects/content-engine/inputs/voice-of-customer/`
   holds files other than the read-me) -> `projects/content-engine/content/0-voice-of-customer/`
4. **content-gap-analysis**, then **keyword-prioritization**
   -> `projects/content-engine/content/keyword-ideas.csv`

## Merge into one list

Write `projects/content-engine/content/opportunities/{date}.md`:

1. **Do these first:** the top five, each with the exact command to run.
2. **The full list,** 20 rows at most:

   | Opportunity | Type | Evidence | Why now | Next step |
   |---|---|---|---|---|

   - **Type** is one of: new article, refresh, title fix, repurpose.
   - **Evidence** names the source and its numbers or links (Search Console figures, the
     threads, the review theme, the customer quote, the competitor page).
   - **Next step** is the command:
     `/content-engine:blog-pipeline "..."`, `/content-engine:update-pipeline "url"`, the
     `title-and-meta` skill, or `/content-engine:repurpose "slug"`.

3. **What was skipped** and what connecting it would add.

**How to rank:** an item backed by two sources outranks one backed by one. A topic close to
what the user sells outranks a bigger generic one. A fix to a page that already ranks
outranks a new page, when both serve the same topic. Merge duplicates: the same topic found
in Search Console and in a community thread is one row with two pieces of evidence.

## When done

Show the top five in the chat with their commands, and point to the file. Ask which one to
start. Do not start a pipeline unasked.

Follow the data-source toggles. Never invent a volume, a position, a quote or a thread: if a
number cannot be retrieved, leave it blank and say so. Never use em dashes.
