---
name: repurpose-carousel
description: Turn an article, newsletter or transcript into a finished LinkedIn or Instagram carousel. Writes the slide copy and caption, then builds the slides in the brand's look as one image per slide and one PDF ready to upload. Use when repurposing a finished piece into swipeable slides.
---

# Repurpose into a carousel

The source holds the depth. The carousel keeps the core insight, the strongest example and
the clearest phrasing, and drops the rest.

## Input

The source piece: by default the final article for the slug in
`projects/content-engine/content/` (the published version if there is one, otherwise
`6-drafts-cited/{slug}.md`), or any file, URL or pasted text the user gives.

Read `projects/content-engine/your-setup/brand-and-voice.md` first. The voice rules apply
to slides as much as to articles.

## Rules

1. **One idea per slide.** If a slide needs "and", it is two slides.
2. **Shorten everything.** Paragraphs become short sentences, bullets or stacked lines.

   Source: "GitHub stores workflows, prompts and AI systems."

   Slide:
   GitHub stores:
   - Workflows
   - Prompts
   - AI systems

3. **Definitions as pairs.** "Repository = project folder."
4. **Each slide earns the next swipe.** End a slide on a question or an unfinished thought
   only when the next slide answers it.
5. **Only what the source says.** Every number and claim on a slide is in the source, with
   its source. Nothing new is added here.

## Structure

| Slide | Job |
|---|---|
| 1 | Hook: the specific claim, number or question the piece answers |
| 2 | Why it matters to this reader |
| 3 to 6 | The core ideas, one per slide, with the strongest example |
| 7 | The takeaway in one line |
| 8 | One call to action |

Eight to ten slides. Fewer is fine when the idea is small.

**The hook is specific, not a formula.** "Most marketers get this wrong" could sit on any
carousel, so it says nothing. Use the piece's own most surprising number, finding or claim.

## Caption

- An opening line that stands on its own in the feed.
- Two or three lines of context the slides do not carry.
- One call to action. Follow the link convention in `brand-and-voice.md`; if it gives none,
  ask whether the link goes in the caption or the first comment.

## Output: the copy, then the slides

The job is a carousel someone can upload, not a script for one. Do both parts.

### 1. The copy

Write `projects/content-engine/content/9-repurposed/{slug}/carousel.md`: the exact text per
slide and the caption. If quality gates are on, the channel gate runs on this file, and the
person approves or updates the copy before any slide is built.

### 2. The slides

1. **The look.** Read the "Visual look" section of
   `projects/content-engine/your-setup/brand-and-voice.md`. If it is missing or empty, look
   for a design guide in this folder (`CLAUDE.md`, `wiki/brand/`, a design skill). If there
   is none, ask once for the brand's colours (background, text, one accent), its heading
   and body fonts, and the name or logo text for the footer, and save the answers under
   "Visual look" so nobody is asked twice. If the person has no answer, use the template as
   it is and say so.
2. **Build the file.** Copy `${CLAUDE_PLUGIN_ROOT}/plugin/slides/carousel-template.html` to
   `projects/content-engine/content/9-repurposed/{slug}/carousel/carousel.html`. Set the
   values in `:root` to the brand's look and write one slide block per slide, with the text
   from `carousel.md` word for word. Slides are 1080 x 1350. Use the `accent` slide for the
   hook, the `dark` slide for the call to action, lists and boxes for stacked lines, and a
   small source line under any number. A chart or diagram a slide needs is drawn in the
   HTML. A screenshot is used only if the file exists; never a placeholder box.
3. **Render.** Run
   `bash "${CLAUDE_PLUGIN_ROOT}/plugin/render-slides.sh" "<path to carousel.html>"`.
   It writes `slide-1.png` to `slide-N.png` and `carousel.pdf` next to the HTML. LinkedIn
   takes the PDF as a document post. Instagram takes the images.
4. **Look at every slide.** Open each PNG and check it: no text cut off or running into the
   footer, nothing unreadable, the slide number right. Fix the HTML and render again until
   every slide is clean. Do not call it done on the render alone.
5. **Show it.** Give the person the PDF and say where the images are.

**No browser to render with** (the script says `NO_BROWSER`): keep the HTML, tell the person
it opens in any browser and prints to PDF from there, and say plainly that the images were
not built.

**Where image files go.** If this folder's `CLAUDE.md` names a place for image files or
says they stay out of git, pass that folder as the script's second argument and put the
HTML there too.

Nothing is posted. Uploading is the person's step. Never use em dashes.

Credit: the compression rules and slide flow come from Tarek Reslan's carousel repurposing
skill, taught in CXL's "Create and repurpose platform-native social content".
