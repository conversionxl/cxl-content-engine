---
description: Run the full content creation pipeline on a keyword, from research to a styled preview. Usage: /content-engine:blog-pipeline "keyword" [optional steering notes]
argument-hint: "keyword" [notes to steer the article]
---

Run the full blog creation pipeline for: **$ARGUMENTS**

## First, check the setup

Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>"`. It never
overwrites a file, and prints where the engine folder is and whether personalisation is done.

- If it prints `Personalisation: NOT DONE`, STOP. Tell the user to run `/content-engine:setup`
  first, and why: the engine will not write against placeholder brand data. Do not continue.
- If `.claude/folders.json` exists, every `projects/content-engine/...` path in this command and
  in the skills it invokes is read and written under the engine folder the script printed.

## Parse the input

- The first quoted phrase is the **keyword** or topic.
- Anything after it is **steering context**: angles to take, sub-topics to cover,
  products to feature, things to avoid. This is the user's front-loaded direction and it
  shapes every step. Save it to `projects/content-engine/content/1-research/{slug}-context.md`.
- Derive a **slug** from the keyword (lowercase, words joined by hyphens). Use the same
  slug for every output file so the article's files stay together.

## Run these skills in order, saving each output

For each step, **invoke the named skill with the Skill tool** (each is listed as `content-engine:<name>`). Do not perform the step from
memory: the skill file holds the current instructions and must be loaded each run. When the
skill returns, save its output file, then move to the next step. The saved files are how the
user debugs a bad result, so never skip them. If you skip a conditional step, say so.

1. **voice-of-customer-mining** *(conditional)*. Invoke only if `projects/content-engine/inputs/voice-of-customer/`
   contains files. It mines real buyer language and pain points -> `projects/content-engine/content/0-voice-of-customer/{slug}.md`.
   If the folder is empty, the skill will surface a one-time nudge to add material; report
   that and continue.
2. **research** -> `projects/content-engine/content/1-research/{slug}.md`
3. **answer-engine-audit** (topic mode) -> `projects/content-engine/content/1-research/{slug}-aeo.md`
4. **your-reference** -> `projects/content-engine/content/2-reference/{slug}.md`
5. **outline** -> `projects/content-engine/content/3-outlines/{slug}.md`
6. **product-mentions** -> `projects/content-engine/content/4-outlines-annotated/{slug}.md`
7. **draft** -> `projects/content-engine/content/5-drafts/{slug}.md`
8. **verify-claims** -> `projects/content-engine/content/6-drafts-cited/{slug}.md`
9. **visuals** (only if turned on in `projects/content-engine/your-setup/data-sources.md`) -> `projects/content-engine/content/images/{slug}/`
10. **preview** -> `projects/content-engine/content/7-preview/{slug}.html`

Apply the steering context and the user's `projects/content-engine/your-setup/` files at every relevant step.

## When done

Tell the user where each file is, open or point them to the HTML preview, and ask if they
want to adjust any single step (you can re-run just that skill) or format it for publishing
with the `format-for-publish` skill.

Do not invent data. Follow the data-source toggles. Never use em dashes.
