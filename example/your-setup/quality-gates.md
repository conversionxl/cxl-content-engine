# Quality gates

**Gates:** on
**Decision model:** none

> A gate that passes everything is not a gate. These three check the work at the points where a wrong call gets expensive: before you write, before you publish, and before a piece goes to a new channel. They are yours to tune: change a row here and the matching question in `gates/`.

## How a gate works

1. **Claude scores every row** pass, partly or fail, with the line of evidence it used. If you use another model in place of Claude, that model does this step.
2. **Code checks run.** Things a model counts badly are counted: em dashes, avoided words, slide and subject length.
3. **A decision model answers the same rows, if you switched one on.** Jev (TypeSafe) or Clef (Cloudflare) returns a probability per row. It is a second opinion. It never changes Claude's score and never approves anything.
4. **One result, in plain words:** Ready, Needs a look or Needs fixing, with what to fix and where.
5. **You decide, every time:** approve and carry on, update and check again, or stop. A gate never moves the work on by itself, and the piece carries a status line saying which of these happened.

| Result | When |
|---|---|
| Needs fixing | A must-pass row fails for Claude, or for every decision model that ran, or a code check fails |
| Needs a look | Not that, and two or more other rows fail, or the checkers disagree on any row |
| Ready | Everything else |

**Decision model settings** (the line at the top): `none`, `jev`, `clef` or `both`. Keys live in `~/.config/decision-models.env`, never in this folder and never in the chat. With `none`, or if a call fails, the gate runs on Claude alone and says so.

To switch every gate off, set **Gates:** to `off`.

## Gate 1, strategy: after Find, before anything is written

Run by `/content-engine:opportunities` on its top items. Questions: `gates/strategy-questions.json`.

| # | Check | Must pass | Where it comes from |
|---|---|---|---|
| S1 | The opportunity leads naturally to something in the offer described in the header. | Yes | Gaetano DiNardi: start at the bottom of the funnel |
| S2 | The person searching this topic is close to choosing a product or service like the one in the header. |  | Gaetano DiNardi: commercial intent over volume |
| S3 | The evidence for the opportunity comes from at least two different sources. |  | Tarek Reslan: one loud thread is not a trend |
| S4 | Every number in the evidence names the tool or page it came from. | Yes | Engine rule: no metric without a source |
| S5 | The opportunity names data, customer language or a point of view of the brand's own that the pages ranking now do not have. |  | Andy Crestodina: better inputs, your own data and point of view |
| S6 | The topic belongs to the subjects the brand writes about, as listed in the header. | Yes | Brand and voice file |
| S7 | The next step is the smallest one the evidence supports: a title fix or a refresh where a page already ranks, a new article only where none does. |  | Tarek Reslan: decision framework for search data |
| S8 | The opportunity says how the piece earns a visit or a citation when an AI answer covers the topic. |  | Alex Birkett and Steve Toth: mentions and citations drive inclusion |
| S9 | The difficulty of the keyword and the sites ranking now do not rule the brand out. |  | Ryan Law: winnability in keyword prioritization |

## Gate 2, draft: on the finished article, before the preview

Run by `/content-engine:blog-pipeline` and `/content-engine:update-pipeline`. Questions: `gates/draft-questions.json`.

| # | Check | Must pass | Where it comes from |
|---|---|---|---|
| D1 | The first screen of the article answers the question behind the target keyword. |  | Tarek Reslan: search intent match |
| D2 | Every statistic and factual claim in the article has a link or a named source next to it. | Yes | Ryan Law: verify claims |
| D3 | Every statement about a competitor has a link or a named source next to it. | Yes | Gaetano DiNardi: a source for every competitor claim |
| D4 | The article contains at least one example, number or experience that comes from the brand itself. |  | Andy Crestodina: proprietary data and point of view |
| D5 | The article says something the pages ranking now do not say. |  | Andy Crestodina: the average of the internet test |
| D6 | The section headers are written as questions or as claims. |  | Steve Toth: structure for citation |
| D7 | Each section opens with a sentence that answers its header. |  | Steve Toth: a quotable answer first |
| D8 | The article uses the customers' own words where it describes their problem. |  | Gaetano DiNardi: mine sales calls for buyer language |
| D9 | Every statement about the brand's product matches the offer described in the header. | Yes | Steve Toth: truth alignment |
| D10 | The article has one call to action. |  | Engine writing standard |
| D11 | The article reads like the voice described in the header. |  | Brand and voice file and voice examples |
| D12 | A reader could act on the article without needing another source. |  | Tarek Reslan: usefulness |

## Gate 3, channel: on each repurposed piece

Run by `/content-engine:repurpose`, once per piece. Questions: `gates/channel-questions.json`. The C rows apply to every channel; K rows to carousels, V rows to video scripts, N rows to newsletters.

| # | Check | Must pass | Where it comes from |
|---|---|---|---|
| C1 | Every number and claim in the piece also appears in the source article given in the header. | Yes | Tarek Reslan: repurposing preserves the original insight |
| C2 | The opening states a specific claim, number or question from the source article. |  | Tarek Reslan: hooks, made specific |
| C3 | The piece has one call to action. |  | Engine writing standard |
| C4 | The piece reads like the voice described in the header. |  | Brand and voice file |
| K1 | Carousel only: each slide carries one idea. |  | Tarek Reslan: one idea per slide |
| K2 | Carousel only: the caption adds context that is not on the slides. |  | Tarek Reslan: caption optimization |
| V1 | Video only: the script opens on the claim or the result, with no greeting. |  | Tarek Reslan: the first seconds matter most |
| V2 | Video only: the ending answers what the opening raised. |  | Tarek Reslan: payoff |
| N1 | Newsletter only: the edition gives the reader one useful idea without clicking through. |  | Tarek Reslan: educational content should be actionable |
| N2 | Newsletter only: the subject line says what is inside the edition. |  | Tarek Reslan: subject line guidelines |

## Tuning

- Add a row: add it to the table and to the matching file in `gates/`, as one yes or no statement. One idea per row: "it is on brand and has one call to action" is two rows.
- A row that fails good work is a bad row. Cut it or reword it.
- Before trusting a decision model, run it on 20 to 30 pieces you have already judged and compare. Its makers report scores in the 60s and 70s out of 100 on their own benchmarks: good for a second look, not for approving.
