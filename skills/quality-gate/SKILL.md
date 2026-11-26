---
name: quality-gate
description: Run one of the content engine's three quality gates on a piece of work, and return PASS, REVIEW or FIX with the rows behind it. Strategy gate on an opportunity, draft gate on an article, channel gate on a carousel, video script or newsletter. Uses a decision model (Jev or Clef) as a second check when one is switched on. Use when a command reaches a gate, or when asked to gate, check or score a piece.
---

# Quality gate

Check one piece against the rows of its gate, say what failed and why, and stop for the
person. The gate recommends. The person decides.

## Input

- **Which gate:** `strategy`, `draft` or `channel` (and for `channel`, which one: carousel,
  video or newsletter).
- **The piece:** one opportunity row with its evidence, one article, or one repurposed piece.
  One piece per run. Never a whole folder in one go.

## Before anything

Read `projects/content-engine/your-setup/quality-gates.md`.

- No such file (a folder set up before gates existed): run
  `bash "${CLAUDE_PLUGIN_ROOT}/plugin/setup.sh" "<this folder's absolute path>"`, which adds
  it without touching anything else, then read it.
- `**Gates:** off`: say "Gates are switched off in quality-gates.md" in one line and return.
- Note the `**Decision model:**` line: `none`, `jev`, `clef` or `both`.

The rows to check are the table for this gate in that file. The user may have changed them:
use their version, not what you remember.

## Step 1: score every row yourself

For each row, give **pass**, **partly** or **fail**, and quote or point to the line in the
piece that decided it. No line to point to means you cannot pass the row.

- Judge the piece as it is, not as it could be after an edit.
- "Partly" is for a row met in some places and missed in others. Say where.
- Do not pass a row because the piece is good in general. Each row is its own question.

## Step 2: run the code checks

Count, do not judge. Use the shell:

- **Em dashes:** `grep -c "—" <file>`.
- **Avoided words:** each word or phrase in the avoid list of
  `projects/content-engine/your-setup/brand-and-voice.md`, case-insensitive.
- **The other checks** listed under `code_checks` in the gate's question file (a claim still
  flagged as unverified, slide length, subject length).

A failed code check is a fail, whatever the rows say.

## Step 3: ask the decision model, if one is on

Skip this step if the line says `none`.

1. Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/decision-model.sh" check`. For a model with no
   key, say so in one line and carry on without it. Never ask for a key in the chat: the
   keys go in `~/.config/decision-models.env`, which the user fills in themselves.
2. Write the **state** to a temporary file: a short header, then the piece.
   - Strategy: the offer in two lines and the subjects the brand writes about, then the one
     opportunity row with its evidence.
   - Draft: the target keyword, the offer in two lines, the voice in three lines, then the
     article.
   - Channel: the voice in three lines and the source article, then the one piece.
3. Use the question file for this gate in `projects/content-engine/your-setup/gates/`. For
   the channel gate, send only the C rows and the rows for this channel.
4. Run `bash "${CLAUDE_PLUGIN_ROOT}/plugin/decision-model.sh" <jev|clef> <questions file> <state file>`,
   once per model. Each answer is a probability that the row is true.
   **Long articles go in sections.** Decision models are weak on long inputs and on "every"
   questions. For the draft gate on an article over about 800 words, ask the whole-article
   rows once with the full article, and ask the "every claim" rows (D2, D3, D9) once per
   H2 section, with only that section as the piece. A row's answer is its lowest section
   answer, and the output names that section.
5. Read each answer against the thresholds in the question file: under `fail_below` is a
   fail, under `borderline_below` is borderline, the rest is a pass.

The decision model never changes your score and never approves anything. It is a second
opinion: what matters is where it disagrees with you.

If a call fails, say so in one line with the reason the script printed, and finish the gate
on your own scores.

## Step 4: the result

| Result | When |
|---|---|
| **FIX** | A must-pass row fails for you, or for every decision model that ran, or a code check fails |
| **REVIEW** | Not a FIX, and two or more other rows fail, or the checkers disagree on any row (you with a decision model, or one decision model with the other) |
| **PASS** | Everything else |

One decision model failing a must-pass row on its own is a disagreement, not a FIX. The
first real run showed why: Jev failed "every number names its source" on five items that
Clef and Claude passed. Name the row and the checker, and let the person look.

## Output

Write `projects/content-engine/content/gates/{gate}-{slug}-{YYYY-MM-DD}.md`, and show the
same in the chat:

1. **The result,** in one line, with who checked: "REVIEW. Checked by Claude and Jev."
2. **The table:** row, your score, the decision model's answer if any, and the evidence.
   Fails and disagreements first.
3. **What to do,** only for fails and disagreements: one line each, naming the section and
   the fix, or the step of the pipeline to send it back to.
4. **What was not checked** and why (no decision model, a model without a key, a call that
   failed).

Then stop and ask the person what they want to do: fix it, send it back to a step, or carry
on as it is. A FIX does not block them. It tells them what it costs to carry on.

Never invent an answer for a decision model that did not run. Never use em dashes.

Credit: the gate design (one statement per row, must-pass rows, a decision model as a second
opinion that never approves) follows CXL's Campaign Engine. The rows come from CXL courses by
Andy Crestodina, Gaetano DiNardi, Alex Birkett, Steve Toth and Tarek Reslan, and from Ryan
Law's pipeline.
