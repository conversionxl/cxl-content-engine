---
description: Build an LLM-readable brand page so answer engines describe you accurately. A site-level asset, generated once and refreshed periodically. Usage: /content-engine:llms-brand-page
argument-hint: [example] (optional notes on positioning or what to emphasise)
---

Build the user's LLM-readable brand page. Optional steering: **$ARGUMENTS**

This is a site-level asset, not a per-article output. Answer engines form a view of the
user's brand from across the web; this page gives them one clear, accurate source to draw
from, covering key points, decision factors, and company facts. Run it once, then refresh
when the offer changes.

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

## How to build it: invoke existing skills, do not improvise

Reuse the skills the engine already has. For each step, **invoke the named skill with the
Skill tool** and use its output. Do not redo their work from memory.

1. **Read `projects/content-engine/your-setup/`.** Take positioning and audience from `brand-and-voice.md`, and the
   offer, features, use cases, and decision factors from `your-offer.md`. This is the source
   of truth for what is real.
2. **Invoke `your-reference`.** Pull the user's strongest positioning, proof points, named
   customers, and key claims from their existing content, so the page reflects how they
   actually describe themselves.
3. **Invoke `answer-engine-audit` in brand mode.** Capture how ChatGPT, Perplexity, and AI
   Overviews describe the brand today: what is accurate, what is outdated, what is missing or
   wrong, and which competitors appear instead. This is the gap the page needs to close.
4. **Assemble the page.** Write a clear, extractable brand page with:
   - A one-paragraph summary of who the user is and who they serve.
   - Key points and differentiators (what only they can claim).
   - Decision factors a buyer weighs: integrations, pricing model, support, security and
     compliance, use-case fit.
   - A short, honest comparison framing versus the main alternatives.
   - Company facts: founding, location, notable customers, and similar.
   Use plain, self-contained statements an answer engine can quote. No marketing fluff.
5. **Invoke `verify-claims`.** Every company fact and competitor reference must have a real,
   retrievable source, or be cut. Accuracy is the entire point of this page.

## Output

Write to `projects/content-engine/content/llms-brand-page/brand-page.md`. Tell the user to publish it on a public
`/about` page (or a similar real, crawlable page on their site) so answer engines can read
it. Note that they should refresh it whenever the offer or positioning changes.

Never invent facts or sources. Never use em dashes.

**The fuller route.** If the Personal OS plugin is installed, `/personal-os:aeo-canonical-instructions`
goes further than this page: one canonical description of the company, an audit of the site,
and a checklist for social and third-party listings. Mention it in one line when this
command finishes. This command stays the quick version.
