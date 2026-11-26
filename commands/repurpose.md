---
description: Turn a finished article into other formats: a carousel, a short or long video script, a newsletter edition. Each is rebuilt for its platform, not summarised. Usage: /content-engine:repurpose "slug or url" [carousel] [video] [newsletter] [notes]
argument-hint: [example] "slug or url" [carousel | video | newsletter] [notes]
---

Repurpose: **$ARGUMENTS**

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

- The first quoted item is the **source**:
  - a **slug**: use the latest version of that article in `projects/content-engine/content/`
    (`8-publish/`, then `6-drafts-cited/`, then `updates/7-updated-draft/`);
  - a **URL**: run the `extract-content` skill on it first and derive a slug from the URL;
  - a **file path** or pasted text: use it as it is and ask for a slug.
- Then the **formats**: any of `carousel`, `video`, `newsletter`. With none named, ask which
  ones, in one question. Do not make all three by default.
- Anything else is **steering**: the audience, the platform, the one idea to lead with.

## Check the source

The source has to be finished. If the slug only has a draft that has not been through
`verify-claims`, say so and ask whether to continue: a repurposed piece carries every
unchecked claim to a new audience.

## Run one skill per format

**Invoke the named skill with the Skill tool** (each is listed as `content-engine:<name>`).
Save each output before starting the next.

| Format | Skill | Output |
|---|---|---|
| `carousel` | **repurpose-carousel** | `projects/content-engine/content/9-repurposed/{slug}/carousel.md` (the copy), then `carousel/slide-N.png` and `carousel/carousel.pdf` (the slides, built once the copy is approved) |
| `video` | **repurpose-video** (ask short or long-form if not said) | `.../9-repurposed/{slug}/video-short.md` or `video-long.md` |
| `newsletter` | **repurpose-newsletter** | `.../9-repurposed/{slug}/newsletter.md` |

## Gate each piece

**Carousel:** the gate runs on the copy. On approve, go back to the **repurpose-carousel**
skill for its second part, which builds the slides and the PDF. A carousel is not done
while it is only a text file.

After each format is written, run the **quality-gate** skill, gate `channel`, on that one
piece -> `projects/content-engine/content/gates/channel-{format}-{slug}-{date}.md`. Its first
row is the one that matters most here: every number and claim in the piece is also in the
source article.

Show the result and **stop** before the next format. The skill asks: approve, update or
stop. On update, the fixes are made and the gate runs again. Only then move to the next
format. If gates are off in `quality-gates.md`, skip this and say so in one line.

## Rules for every format

- **Rebuild, do not summarise.** Each format leads with what works on its platform.
- **Nothing new.** Every claim and number comes from the source piece, with its source. If a
  format needs a fact the source lacks, flag it. Do not add it.
- **The user's voice.** `brand-and-voice.md` and the voice examples apply to every format.

## When done

List the files written, each with its gate result. Remind the user that nothing is posted or sent: publishing is their
step, in their own tools. Never use em dashes.
