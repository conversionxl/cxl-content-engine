---
name: quality-gate
description: Run one of the content engine's three quality gates on a piece of work. Returns a plain verdict (Ready, Needs a look or Needs fixing) with what to fix and where, then stops and asks the person to approve, update or stop. Strategy gate on an opportunity list, draft gate on an article, channel gate on a carousel, video script or newsletter. Uses a decision model (Jev or Clef) as a second check when one is switched on. Use when a command reaches a gate, or when asked to check a piece.
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

- **Em dashes:** `grep -c "$(printf '\xe2\x80\x94')" <file>` (the character is written as bytes so this file holds none).
- **Avoided words:** each word or phrase in the avoid list of
  `projects/content-engine/your-setup/brand-and-voice.md`, case-insensitive, **in the
  writer's own prose only**. A match inside a URL, inside quotation marks (someone else's
  words), inside a code span, or in the proper name of a product or page does not count.
  List those under "ignored" so the person can see them, and do not fail the check on them.
- **The other checks** listed under `code_checks` in the gate's question file (slide length,
  subject length, a claim still flagged). A flagged claim is one the pipeline itself marked
  as unverified: by `verify-claims` in the create pipeline, by `update-claims` in the
  refresh pipeline. A claim the user has confirmed in the chat is no longer flagged.

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

**A borderline answer is not a fail and not a disagreement.** List it under "close calls"
with its number. It changes the result only when you scored the same row "fail".

One decision model failing a must-pass row on its own is a disagreement, not a FIX. The
first real run showed why: Jev failed "every number names its source" on five items that
Clef and Claude passed. Name the row and the checker, and let the person look.

## Output: written for someone who has two minutes

The person reading this did not watch the gate run. They need three things at a glance: is
it good, what is wrong, and what do I do. Write for that reader.

**Rules for the wording**

- Name each check in plain words ("Every claim has a source"), never by its code (D2, S5).
  Codes appear only in the details table at the very end.
- No probabilities in the main part. "Jev disagrees" is enough. Numbers go in the details.
- One line per item. No paragraphs.
- Say what to do about every problem. A problem with no fix next to it is noise.

**Write `projects/content-engine/content/gates/{gate}-{slug}.md`** (one file per piece, kept
across rounds: add each new round at the top, do not make a new file), and show the same in
the chat, in this order:

```
# Check: <what was checked, in plain words>

## Verdict: <READY | NEEDS A LOOK | NEEDS FIXING>   (round <n>, <date>)

<One sentence that a busy person could act on. "Ready apart from two unsourced figures in
the pricing section.">

Checked by: <Claude | Claude and Jev | Claude, Jev and Clef>

## Needs fixing
| Problem | Where | Fix |
(Only what must change before going on. If nothing: "Nothing.")

## Worth a look
| What | Where | Why it is flagged |
(Smaller problems, close calls, and rows where the checkers disagree, with who said what
in words. If nothing: "Nothing.")

## Good
- <the checks that passed, grouped in three to five short bullets>

## What changed since the last round
| Check | Last round | This round |
(From round 2 on. Only checks whose result changed, plus one line on what was edited.)

## Your call
1. **Approve:** carry on to <the next step, named>.
2. **Update:** I make the fixes above, then check again.
3. **Stop:** leave it here.

## Details
(The full table: check, code, Claude, each decision model with its number, the evidence
line. And what was not checked, and why.)
```

**Verdict words.** READY is a PASS, NEEDS A LOOK is a REVIEW, NEEDS FIXING is a FIX. Use the
plain words everywhere the person reads. The old words may appear in the details only.

## After the gate: approve, update or stop. Always.

A gate never moves the work on by itself. After showing the result, **stop and ask** the
three options under "Your call", whatever the verdict, READY included. Then:

- **Approve:** stamp the piece (below) and return to the command, which carries on.
- **Update:** make the fixes listed under "Needs fixing", and under "Worth a look" if the
  person says so. Edit the piece that was checked, or send it back to the step named in the
  fix. Then run the gate again as the next round and ask again. There is no limit on
  rounds: the person decides when it is done.
- **Stop:** stamp the piece as stopped and end the command there.

**Stamp the piece, so anyone opening it knows where it stands.** Put this block at the very
top of the file that was checked (for an article, at the top of the draft file; for the
Find list, at the top of the list), and keep it current:

```
> **Status:** <Approved | Updated, waiting for a check | Needs fixing | Stopped>
> **Checks:** round 1 on <date>: <verdict>. <Edited on <date>: what changed, in one line.>
> round 2 on <date>: <verdict>. <Approved by you on <date>.>
> Full result: `content/gates/<file>`
```

Every edit made after a gate adds a line there. A piece with no such block has not been
through a gate. Remove the block when the piece is formatted for publishing.

**Unattended runs.** If the person said up front not to ask (a test run, a scheduled run),
do not ask: write the result, stamp the piece "Not approved by a person", and carry on.
Say so in the closing message.

Never invent an answer for a decision model that did not run. Never use em dashes.

Credit: the gate design (one statement per row, must-pass rows, a decision model as a second
opinion that never approves) follows CXL's Campaign Engine. The rows come from CXL courses by
Andy Crestodina, Gaetano DiNardi, Alex Birkett, Steve Toth and Tarek Reslan, and from Ryan
Law's pipeline.
