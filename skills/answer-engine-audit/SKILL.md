---
name: answer-engine-audit
description: Check what AI answer engines (ChatGPT, Perplexity, Google AI Overviews, Claude) currently say about a topic or the user's brand, and which sources they cite. Use early in content creation and updates, and inside the llms-brand-page command.
---

# Answer-engine audit

Search is no longer ten blue links. Buyers ask ChatGPT, Perplexity, and Google's AI mode and
read a synthesised answer. Ranking is not enough; you need to be the source the answer cites,
and you need the answer about your brand to be accurate. This skill checks both.

## Two modes

### Topic mode (used in the pipelines)

For a given keyword or topic:

1. Pose the core question behind the topic to the answer engines you can reach (built-in web
   search of AI Overviews and live queries to any AI tools available). Capture the consensus
   answer they give.
2. Note **which sources they cite** and which sites keep reappearing. These are the pages
   winning the citation, and the bar to clear.
3. Identify the **angle or evidence** that is missing from the current answer, where original
   data, a clearer definition, or the user's POV could earn the citation instead.
4. Note the **decision factors** the answers emphasise for the category.

### Brand mode (used by `/content-engine:llms-brand-page` and updates)

For the user's brand:

1. Ask the answer engines who the user is, what they do, who they are for, and how they
   compare to named competitors.
2. Record what is **accurate**, what is **outdated**, and what is **missing or wrong**. This
   is the truth-alignment gap: the difference between reality and what the models believe.
3. Note where the brand is absent from answers it should appear in (for example "best X for
   Y" prompts), and which competitors show up instead.

## Honesty

Report only what the engines actually return. Do not guess what an answer engine "probably"
says. If you cannot reach a given engine, say which ones you checked and how. Quote answers
accurately; do not embellish.

## Say how each engine was checked

Most sessions cannot query ChatGPT, Perplexity or Google's AI mode directly: they sit behind
a sign-in. Do not present a web search as what an engine said. Open the output with this
table, filled in honestly:

| Engine | How it was checked |
|---|---|
| Google AI Overviews | Read from the keyword tool's results-page data, with its date / seen in a live search / not checked |
| ChatGPT | Asked directly / not reachable from this session |
| Perplexity | Asked directly / not reachable from this session |
| Claude | Asked directly (this model, with web search on or off) |

If an engine was not reachable, say what the user can do: paste its answer to one or two
questions into the chat, and the audit will use it. Mark every finding with the engine it
came from. A finding from one engine is not "what AI says".

## Output

**A command's save path wins.** When a pipeline command names where this audit goes (the
refresh pipeline uses `projects/content-engine/content/updates/6-aeo/{slug}.md`), save it
there and nowhere else. The paths below are for the create pipeline and for running this
skill on its own.


- Topic mode: write to `projects/content-engine/content/1-research/{slug}-aeo.md` (consensus answer, who gets cited,
  the citation gap, decision factors). Feeds `research`, `outline`, and `update-topic-gaps`.
- Brand mode: write to `projects/content-engine/content/answer-engine-audit/brand.md` (accurate, outdated, missing,
  competitor presence). Feeds `/content-engine:llms-brand-page` and update guidance.
