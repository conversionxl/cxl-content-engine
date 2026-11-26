---
description: Refresh an existing published article, from extracting it to a full preview of the new article with changes marked inline. Usage: /content-engine:update-pipeline "url" [optional steering notes]
argument-hint: [example] "https://your-site.com/article" [notes on what to focus on]
---

Run the full content update pipeline for: **$ARGUMENTS**

## First, check the setup

Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>"`. It never
overwrites a file, and prints where the engine folder is and whether personalisation is done.

- If it prints `Personalisation: NOT DONE`, STOP. Tell the user to run `/content-engine:setup`
  first, and why: the engine will not write against placeholder brand data. Do not continue.
- If `.claude/folders.json` exists, every `projects/content-engine/...` path in this command and
  in the skills it invokes is read and written under the engine folder the script printed.

## Example mode

If the first word of the input is `example`, this run is on **Acme Deals**, a fictional brand
that is already set up. Run the setup script with `example` as a second argument:
`bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>" example`

- The script prints `Example folder:`. For this whole run, every `projects/content-engine/...`
  path in this command and in the skills it invokes is read and written under that folder
  instead (`.../example/your-setup/`, `.../example/inputs/`, `.../example/content/`). Tell each
  skill so when you invoke it.
- Ignore the `Personalisation:` line. The example needs no setup, and never reads or changes
  the user's own setup or content.
- Open with one line: "Running on Acme Deals, a fictional brand. Nothing here touches your
  own setup."
- Take `example` off the input, then parse the rest as usual. Where this command expects a
  published URL, example mode takes a slug and reads
  `content/8-publish/{slug}.md` in the example folder as the published article.
- The Search Console export in the example is made up. Label any figure from it "dummy
  data" in the output. Web search results are real: keep the two apart.
- Every next-step command you print carries `example` as its first word, and names a
  published article by its slug, not its URL
  (`/content-engine:update-pipeline example "still-using-it-in-six-months"`). If the example
  folder has no file for a slug, say so.
- Nothing is published and no CMS is asked about.

## Parse the input

- The first quoted item is the **URL** of the article to refresh.
- Anything after is **steering context**: what to focus on, what to leave alone.
- Derive a **slug** from the URL and use it for every output file.

## Run these skills in order, saving each output

For each step, **invoke the named skill with the Skill tool** (each is listed as `content-engine:<name>`). Do not perform the step from
memory: the skill file holds the current instructions and must be loaded each run. When the
skill returns, save its output file, then move to the next step. Never skip the saves.

1. **extract-content** -> `projects/content-engine/content/updates/1-extracted/{slug}.md`
2. **update-guidance** (set priorities, triage the content type, fold in steering) -> `projects/content-engine/content/updates/0-guidance/{slug}.md`
3. **answer-engine-audit** (brand + topic: how answer engines cover and represent this now) -> `projects/content-engine/content/updates/6-aeo/{slug}.md`
4. **update-claims** (outdated stats, find current replacements) -> `projects/content-engine/content/updates/2-update-claims/{slug}.md`
5. **update-product-mentions** (new features worth adding) -> `projects/content-engine/content/updates/3-update-product-mentions/{slug}.md`
6. **update-topic-gaps** (gaps vs the SERP and what answer engines cite) -> `projects/content-engine/content/updates/4-update-topic-gaps/{slug}.md`
7. **update-draft** (consolidate the audits into a revised article) -> `projects/content-engine/content/updates/7-updated-draft/{slug}.md`
8. **update-preview** (full refreshed article with changes marked inline) -> `projects/content-engine/content/updates/5-update-preview/{slug}.html`

## When done

Open or point the user to the preview so they can read the full refreshed article and see
exactly what changed inline, then accept or reject the update. Remind them nothing is
published until they say so.

Follow the data-source toggles. Do not invent replacement stats: every changed number must
have a real, retrievable source. Never use em dashes.
