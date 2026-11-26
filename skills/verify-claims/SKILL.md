---
name: verify-claims
description: Go through a draft, find every factual claim and statistic, find a real source for each, add the hyperlink, and flag anything that cannot be verified.
---

# Verify claims

Make the article trustworthy. This step is why the engine can be trusted at scale: it
checks the facts rather than hoping they are right.

## Input

Draft: `projects/content-engine/content/5-drafts/{slug}.md`.

## Steps

1. Read the draft and list every factual claim, statistic, and named fact.
2. For each, find a real, current, retrievable source. Prefer primary sources over
   summaries. Use the data tools that are on in `projects/content-engine/your-setup/data-sources.md`, plus
   built-in web search.
   - **Competitor and market claims get the strictest treatment.** Any statement about a
     rival ("their pricing went up", "users complain about X") must link to a real source:
     a review site, a changelog, a primary doc. An unsourced competitor claim is hearsay and
     a legal risk. Cite it or cut it.
3. Add the source as a hyperlink at the claim, or as a citation, matching how the user's
   voice examples handle sourcing.
4. **Flag anything you cannot verify.** Do not quietly leave an unsourced stat in. Mark it
   clearly so the user can fix or cut it. If a number turns out to be wrong or outdated,
   correct it and note the change.
5. Confirm internal links from earlier steps still point somewhere sensible.
6. **Label each claim** in your working list: `verified` (a primary source says it),
   `likely` (a credible secondary source says it), `uncertain` (sources disagree or are
   old) or `wrong`. Only `verified` and `likely` stay in the article as written. Soften an
   absolute statement the sources do not support ("guarantees", "always", "the best").
   Check that every tool or product feature named still exists and works as described.

## Quality check, in the same pass

One gate, not two. While the draft is open, check these six and list any that fail:

| Check | Fails when |
|---|---|
| Intent | The article does not answer the query in its first screen, or the format does not fit what the searcher wants |
| Depth | A subtopic the top results all cover is missing with no reason |
| Structure | Headers are not question or claim shaped, or a section does not open with its answer |
| Usefulness | A reader could not act on it without another source |
| Credibility | No first-hand example, data or named experience from the user anywhere in the piece |
| Difference | It fails the "average of the internet" test: the same piece could come from a one-line prompt |

Do not rewrite the article here. List the failures with the section they are in, so the
user can send it back to `draft` or fix it by hand.

## Hard rule

Never fabricate a source, URL, statistic, or quote. If you cannot find a real source for a
claim, say so and flag the claim. An honest gap is better than an invented citation.

## Output

Write the cited draft to `projects/content-engine/content/6-drafts-cited/{slug}.md`, with a short list at the end
of any claims you flagged for the user's attention, and any quality checks that failed.

Credit: the claim labels and the six quality checks come from Tarek Reslan's fact-check and
SEO quality check skills, taught in CXL's "Create research-backed and search-optimized
content".
