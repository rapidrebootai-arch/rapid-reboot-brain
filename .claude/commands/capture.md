---
description: Quickly capture a thought, idea, or observation into the vault without worrying about format or category. Use when the user says "capture this", "remember this", "quick thought", "just save this", "idea:", or pastes something short with no other context. Designed to be the lowest-friction entry point into the vault — faster than /ingest, more permanent than a sticky note.
---

# /capture — Quick Thought Capture

The fastest way to get something into the vault. No structure required. The user throws something at you — a half-formed idea, a quote they heard, something they noticed, a random thought, a voice memo transcript — and you catch it, make sense of it, and file it properly.

## The core principle

`/capture` is for thoughts that haven't fully formed yet. Unlike `/ingest` (which processes complete sources) or `/log` (which tracks project progress), `/capture` is for the raw stuff — the kind of thing that usually gets texted to yourself and forgotten, or written on a sticky note that disappears.

The user should be able to use this command mid-thought. Don't make them think about where it goes or what it is. That's your job.

## Input

The user will either:
- Type `/capture` followed by their thought
- Type `/capture` alone, then paste or type when prompted

If nothing follows the command, ask with a single line: "What's on your mind?"

Accept anything: a sentence, a paragraph, a voice memo transcript, a URL with a comment, a quote, a name with context, an observation, a question they want to think about later.

## Workflow

### Step 1: Read the thought

Take it at face value. Don't try to clean it up or over-interpret it yet. Read it once.

### Step 2: Classify it (internally — don't ask the user)

Quickly infer the type. This shapes how you file it:

- **Idea** — something the user wants to do, try, build, or explore. May be fully formed or half-baked.
- **Observation** — something they noticed in the world. A pattern, a trend, something that struck them.
- **Quote or reference** — something someone else said or made that resonated.
- **Question** — something they want to think through or answer later.
- **Person note** — context about someone worth remembering.
- **Project thought** — a thought that clearly belongs to an active project.
- **Misc / unclassified** — genuinely unclear. File it and move on.

### Step 3: File it

**If it's a Project thought** — find the matching Project note and append a `## Captures` section entry (create the section if missing). Link back to today's Daily note.

**If it's a Person note** — find or create the Person note and add it under `## Notes`.

**If it's anything else** — create a new Concept note in `Concepts/`. Title it as a noun phrase that captures the core idea (not the user's exact words unless they're already perfect). Keep the note short — 2-5 sentences max. Tag it `#capture` so the user can find all raw captures later and flesh them out.

Also append a one-line reference to today's Daily note under `## Notes` or `## Captures` (create section if needed):
```
- [TIME] Captured: [[Concept note title]]
```

### Step 4: Link it

Even for a raw capture, try to link it to one or two existing notes. Does this idea connect to something already in the vault? If yes, add a `## Related` link. If nothing obvious connects, leave it — don't force links.

### Step 5: Confirm briefly

One or two lines max:

> Captured as [[Note title]] in Concepts/. Tagged #capture.

Or if it went to a project:

> Added to [[Project name]] captures.

That's it. Don't summarize back to them. Don't ask follow-up questions unless something is genuinely ambiguous (like "who is this person you mentioned?"). Get out of the way fast.

## Speed is everything

The whole point of `/capture` is that it costs the user almost nothing. If your response is long, they'll hesitate next time. Aim for the interaction to feel like tossing something into a box — quick, low-effort, done.

The vault does the organizing. The user does the thinking later (or never — some captures are just there if needed).

## Examples of good captures and how to handle them

**Input:** `the best brands don't explain themselves`
→ Concept note: `Strong brands don't over-explain` — tag #capture, link to any brand-related projects or concepts already in vault.

**Input:** `looked up Marcus today — he's the buyer at REI, met him at OR show, interested in compression`
→ Person note for Marcus — add role, company, context, interest in compression. Link to any REI or retail-related notes.

**Input:** `what if the clothing brand leaned into recovery as a lifestyle, not just post-workout`
→ Concept note: `Recovery as lifestyle positioning` — this is an idea worth exploring. Tag #capture, link to clothing brand project if it exists.

**Input:** `Trevor said something about how the best performing ads always have a villain`
→ Concept note: `High-performing ads need a villain` — attribute to Trevor in the note body. Link to any ad performance or Meta ads concepts.

**Input:** a 3-paragraph voice memo transcript about a supplier call
→ This is too big for `/capture`. Tell the user: "This looks like more than a quick thought — want me to run `/ingest` on it instead? That'll extract proper notes and link everything up."

## Edge cases

**Sensitive personal content** — file it as-is, no commentary. The vault is theirs.

**Something that already exists in the vault** — if you recognize the concept, append to the existing note rather than creating a duplicate. Note the overlap briefly: "Added to existing note [[X]]."

**A URL with no context** — ask one question: "What did you want to remember about this?" If they don't answer, create a stub Concept note with the URL and tag #capture #stub.

**A name with no context** — create a Person stub with just the name and tag #stub. Don't guess at who they are.

## Don't

- Don't ask "what project does this belong to?" — infer it or file it in Concepts
- Don't create long, structured notes from a quick capture — that defeats the purpose
- Don't lecture the user about how to phrase captures better
- Don't run `/ingest` automatically on large content — suggest it and let them decide
- Don't update CONTEXT.md for every capture — that's too noisy
