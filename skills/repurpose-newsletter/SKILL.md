---
name: repurpose-newsletter
description: Turn an article or transcript into a newsletter edition in your voice, matched to your past editions for structure, length and pacing, with subject line options and the article's images. Then builds it as a draft in your email tool, or as an HTML file. Use when repurposing a finished piece for your email list.
---

# Repurpose into a newsletter

A newsletter is not an article summary with a link. It gives the reader one useful idea in
the inbox, then offers the full piece to those who want more.

## Input

The source piece: by default the final article for the slug in
`projects/content-engine/content/`, or any file, URL or pasted text the user gives.

**Past editions are the guide.** Look for the user's own newsletters in
`projects/content-engine/your-setup/voice-examples/` (any file with "newsletter" in the
name, or that the user points to). Two or three are enough. If there are none, ask the user
to paste one or two past editions, or say that the edition will follow
`brand-and-voice.md` only and may need more editing.

## Steps

1. **Name the goal:** the one idea this edition delivers, who it is for, and the single
   action you want. **Ask what the edition promotes at the end** if the person has not
   said: the article is not the default. Most editions end on an offer, an event or a
   product, and link the article in the body for readers who want the detail. One button,
   for the thing it promotes. The article is a text link.
2. **Read the past editions** and note the structure, the length, how they open, how they
   move between sections and how they close. Match the pattern. Do not copy sentences.
3. **Choose the one idea.** An article has several. The edition carries the most useful one
   in full and leaves the rest for the click.
4. **Write it:**
   - an opening that starts with the reader's situation or the finding, not with "this week"
   - the idea, explained so it is useful without clicking
   - one takeaway the reader can act on today
   - one call to action
5. **Add the visuals.** Pick two or three images from the source article (a diagram, a
   chart, a screenshot) and place each next to the paragraph it supports. Use the image's
   published URL and its alt text. An article with no images gets none: never a
   placeholder, and never an image made up for the email.
6. **Check it:** short paragraphs, easy to skim, no claim or number that is not in the
   source piece.

## Subject lines

Three to five options. Each says what is inside, in plain words, and is short enough to
read on a phone. No clickbait and no vague teasers.

## Output: the copy, then the email

The job is an edition someone can send, not a text file about one. Do both parts.

### 1. The copy

Write `projects/content-engine/content/9-repurposed/{slug}/newsletter.md`: the subject line
options with a pick, a preview line, the full edition with each image marked where it goes,
and what it promotes at the end. If quality gates are on, the channel gate runs on this
file, and the person approves or updates the copy before anything is built.

### 2. The email

Ask once where editions are sent from, and whether to build it there. Then:

- **An email tool is connected** (Customer.io, Mailchimp, HubSpot, Brevo or another) **and
  the person says yes:** build the edition there as a **draft**. Start from a copy of the
  last edition that was sent, so the audience, the sender, the header, the footer and the
  unsubscribe link are the ones already in use. Replace the body, set the subject and the
  preview line, and keep any standing block the past editions end with. Run the tool's own
  check if it has one (links, images, unsubscribe) and report what it says. Give the person
  the link to review it.
- **No email tool, or the person says no:** write
  `projects/content-engine/content/9-repurposed/{slug}/newsletter.html`, a plain email
  with the images in place, which pastes into any email tool.

**Never schedule or send on your own.** A draft is the end of this skill. Schedule a send
only when the person asks in their own words, for the date and time they name or a slot
they tell you to pick, and say back who it goes to and how many people before you do it.
Say plainly what you did not check, such as how it looks in an inbox.

Never use em dashes.

Credit: the examples-first method comes from Tarek Reslan's newsletter writing skill, taught
in CXL's "Create and repurpose platform-native social content".
