# Troubleshooting

Common snags and how to fix them. If you are stuck, you can also just ask Claude Code in
plain English: "this is not working, here is what happened."

## "It told me to run /content-engine:setup and will not write anything"

That is the setup gate doing its job. The engine will not write content until you have
replaced the placeholders with your own brand and voice. Run `/content-engine:setup` and answer the
questions. Once every file in `projects/content-engine/your-setup/` is filled in, the engine unlocks.

## The commands do not appear

The plugin is not installed, or this session started before it was. Check **Settings →
Plugins**: Content engine should be listed under the marketplaces you added. Then start a new
chat in your folder. In the desktop app, use the Code tab with Environment set to Local:
cloud sessions do not load plugins.

## The engine wrote to a folder I did not expect

Everything lives in `projects/content-engine/`. If you mapped your own folder names in
`.claude/folders.json`, it lives under your projects folder instead. Run
`/content-engine:setup` again: it prints where the engine folder is and never overwrites.

## The article does not sound like me

You need better voice examples. Add 5 to 10 of your strongest articles to
`projects/content-engine/your-setup/voice-examples/` and run `/content-engine:setup` again. See
[customise-your-voice.md](customise-your-voice.md). Rules alone will not do it; the examples
are what teach your voice.

## A research step gave thin or generic results

By default the engine uses built-in web search. For sharper keyword and SERP data, connect
a data tool and turn it on in `projects/content-engine/your-setup/data-sources.md` (see below).

## Connecting a data tool (Ahrefs, Search Console, Google Analytics, a scraper, or your own)

The quickest route is `/content-engine:setup`: step 4 talks you through each tool, tests
the connection and switches it on.

By hand: in Claude, open **Customize** in the left sidebar, then **Connectors**, find the
tool and sign in. Then set its row to `on` in
`projects/content-engine/your-setup/data-sources.md`. If you use a different tool for the
same job (Semrush instead of Ahrefs, Plausible instead of Google Analytics), put its name in
the Tool column.

A tool that is not in the Connectors list can still work if its maker offers an MCP server:
ask Claude "help me connect" and name the tool. If nothing connects, export a CSV and drop
it in the matching `inputs/` folder.

Does your screen look different? Claude's interface changes often. Tell us and we will
update these steps.

## Connecting a CMS (WordPress, Webflow, others)

Same idea: connect the CMS as an MCP server or via its API, then update
`projects/content-engine/your-setup/cms-connection.md` to `status: connected`. Ask Claude Code "help me connect my
WordPress site" and follow along. Until then, the engine gives you a clean document to copy
and paste, which works everywhere.

## I want to change a step

Installed as a plugin, the steps live in Claude's copy of the plugin, which you do not
edit. For a one-off change, tell Claude in the same message: "run the pipeline, and make
the draft step write shorter intros." For a lasting change, take the advanced route in the
README: download the repository, and every step is a small file in `skills/` (for example
`skills/draft/SKILL.md`) that you can edit. It is meant to be changed.
