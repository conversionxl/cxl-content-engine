

---

## Content engine

<!-- Added by the content-engine plugin. Edit freely. -->

**Four stages: find what to write, create it, keep it current, repurpose it.** The engine works through a chain of small, single-purpose skills. Each skill saves its output to a file, so you can review and fix one step without starting over.

| Folder | What goes in it |
|---|---|
| `projects/content-engine/your-setup/` | Your brand and voice, your offer, your data sources, your CMS connection, and your best articles in `voice-examples/`. Filled in by `/content-engine:setup`. |
| `projects/content-engine/inputs/` | `keywords.csv`, `search-console/` for an export if Search Console is not connected, and `voice-of-customer/` for call transcripts, tickets and survey answers. Voice-of-customer files stay on this machine. |
| `projects/content-engine/content/` | One numbered folder per step, one file per article, named by its slug. `opportunities/` holds the ranked lists of what to make next, `updates/` the refresh flow, `9-repurposed/` the carousels, video scripts and newsletters. |

| Command | What it does |
|---|---|
| `/content-engine:setup` | Adds the engine to this folder and personalises it: documents you already have first, questions only for the gaps. Run it again any time to change something. |
| `/content-engine:opportunities [topic]` | Stage 1, find: one ranked list from your Search Console data, search questions, communities, reviews, customer language and competitor gaps, with the command to run for each item. |
| `/content-engine:blog-pipeline "keyword" [notes]` | Stage 2, create: research, answer engine audit, outline, draft, claims and quality check, preview. |
| `/content-engine:update-pipeline "url" [notes]` | Stage 3, refresh: updates a published article and shows the full new version with changes marked. |
| `/content-engine:repurpose "slug or url" [formats]` | Stage 4, repurpose: a finished article into a carousel, a video script or a newsletter edition. |
| `/content-engine:llms-brand-page` | One page that tells answer engines who you are, built from your setup and how AI describes you today. |

**Rules for the engine:**
- **Setup first.** If any file in `projects/content-engine/your-setup/` still holds `{{REPLACE_ME}}` or `<!-- SETUP_INCOMPLETE -->`, no content command or skill runs. Say so and point to `/content-engine:setup`. Never write against placeholder brand data.
- **Read the setup before writing.** `brand-and-voice.md` (voice, tone, rules), `your-offer.md` (what you sell), `voice-examples/` (your best articles) and `data-sources.md`. The voice examples outrank every abstract rule: when in doubt about tone, match them.
- **A brand brain outranks the questionnaire.** If `wiki/brand/` holds an ICP, positioning or voice file (from the Marketing Brain), setup reads those first and asks only for what they do not answer.
- **Data tools are switches, by job.** Web search works for everyone. `data-sources.md` lists four optional jobs (keyword data, your search performance, site analytics, communities and reviews) and the tool you use for each: Ahrefs, Search Console, Google Analytics 4, Apify or Firecrawl by default, or your own. A job marked `on` uses that tool; `off` falls back to web search. Never invent keyword volumes, traffic or metrics: if a number cannot be retrieved, say so.
- **Save every step** to its file in `projects/content-engine/content/`, also when the full pipeline runs.
- **CMS reminder.** If `cms-connection.md` says `status: later` and `last_prompted` is seven or more days old, ask once whether to connect it now, then set `last_prompted` to today whatever the answer.
- **Writing standards** (your `brand-and-voice.md` overrides them): plain, direct language, short sentences, active voice; no em dashes; no invented statistics, sources or quotes; the most useful point first; one call to action per article.
- **The "average of the internet" test.** Before an article is called done: could the reader get the same piece from a one-line prompt? If yes, it is not worth publishing. Push it back toward your own data, point of view, customer language and examples.
- **Write for answer engines, not only rankings.** Question or claim-shaped headers, a quotable answer at the start of each section, comparison tables, accurate product facts. Tracking how often AI names you over time is a different job: that is the AI visibility builds, not this engine.
- **Three quality gates.** `quality-gates.md` in `your-setup/` holds them: strategy (after Find), draft (before the preview) and channel (each repurposed piece). Claude scores every row with the line that decided it, code counts what models count badly, and a decision model (Jev or Clef) gives a second opinion only if that file says so. The order is always step, gate, your decision, next step: a gate returns Ready, Needs a look or Needs fixing in plain words, then stops and asks you to approve, update or stop. Every checked piece carries a status block at its top saying which round it is, what was edited after each check, and whether you approved it.
- **Example mode.** `example` as the first word after any command runs it on Acme Deals, a fictional brand, inside `projects/content-engine/example/`. Example runs never read or change your own setup or content, and figures from the example Search Console export are labelled dummy data.
- **Your own folder names.** If `.claude/folders.json` exists, every folder named in this section is read at its mapped name.
- **Make it yours.** These skills are a starting point. To change how a step works for good, download the repository and edit its `SKILL.md` (the advanced route in the README), or tell Claude the change you want for this run.

- **Repurposing adds nothing new.** A carousel, script or newsletter carries only claims that are in the source article, with their sources. Nothing is posted or sent by the engine.

Credits: the method comes from CXL courses. The B2B, voice-of-customer and answer engine tactics are from Andy Crestodina, Gaetano DiNardi, Alex Birkett and Steve Toth. The pipeline structure (chained skills, saved step outputs, one command per pipeline) is Ryan Law's approach at Ahrefs. The Search Console opportunity patterns, trend signals from communities and reviews, the title check, the quality check and the repurposing formats come from Tarek Reslan's CXL courses and his two systems.
