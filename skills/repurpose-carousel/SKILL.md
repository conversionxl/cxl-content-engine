---
name: repurpose-carousel
description: Turn an article, newsletter or transcript into a LinkedIn or Instagram carousel, with slide-by-slide copy with one idea per slide, plus the caption. Use when repurposing a finished piece into swipeable slides.
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

## Output

Write `projects/content-engine/content/9-repurposed/{slug}/carousel.md`: the slide-by-slide
copy (exact text per slide), the caption, and a one-line note per slide on any visual it
needs (a chart, a screenshot, a diagram). The engine writes the copy; the design is done in
the user's own design tool. Never use em dashes.

Credit: the compression rules and slide flow come from Tarek Reslan's carousel repurposing
skill, taught in CXL's "Create and repurpose platform-native social content".
