# wingman

**Your personal QA wingman. Finds bugs before anyone else does.**

You finish building a feature. You think it works. You run wingman — and it goes through your entire codebase thinking like a paranoid senior QA engineer who has seen everything go wrong. It finds the negative number that breaks your input. The missing auth guard on that DELETE route. The race condition from double-clicking submit. The third-party API call with no timeout that hangs your checkout at 2am. All the things you missed because you were thinking about making it work, not making it break. Privately. Before you push. Before anyone raises a bug ticket.

Works with Claude Code, Cursor, Windsurf, Zed, and any AI tool that accepts a system prompt.

---

## Install

Run one command in your project directory:

| Tool | Mac / Linux | Windows (PowerShell) |
|------|-------------|----------------------|
| **Claude Code** | `curl -s https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-claude.sh \| bash` | `irm https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-claude.ps1 \| iex` |
| **Cursor** | `curl -s https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-cursor.sh \| bash` | `irm https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-cursor.ps1 \| iex` |
| **Windsurf** | `curl -s https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-windsurf.sh \| bash` | `irm https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-windsurf.ps1 \| iex` |
| **Zed** | `curl -s https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-zed.sh \| bash` | `irm https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-zed.ps1 \| iex` |
| **Any AI tool** | `curl -s https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-universal.sh \| bash` | `irm https://raw.githubusercontent.com/skher9/Wingman/main/scripts/install-universal.ps1 \| iex` |

**Claude Code:** type `/wingman all` to start.
**Cursor / Windsurf:** type `wingman all` in the chat.
**Zed:** select the wingman context in the AI assistant, then type `wingman all`.
**Universal:** paste the downloaded `wingman-prompt.md` into your tool's system prompt field, then type `wingman all`.

---

## Subcommands

| Command | What it does |
|---|---|
| `nitpick` | Basic bugs in the feature you just built — inputs, null handling, missing branches |
| `crossfire` | Reads your git diff and maps every file, module, and API that depends on what changed |
| `scenario` | Traces complete user journeys through the codebase — finds where they silently break |
| `regression` | Finds every test, module, and API consumer at risk from your recent changes |
| `security` | Checks auth gaps, missing permission guards, PII leaks, unsanitized inputs, hardcoded secrets |
| `performance` | Finds N+1 queries, full table scans, unnecessary re-renders, unclean listeners |
| `dataflow` | Traces data through layers — type mismatches, null propagation, unsafe mutations |
| `fallback` | Finds every failure point with no fallback — no catch, no retry, no timeout |
| `edge` | Tests every input at zero, null, empty, max, min, duplicates — semantically, not generically |
| `state` | Maps the state machine — invalid transitions, crash-mid-flow gaps, impossible states |
| `concurrent` | Finds race conditions — double submit, multi-tab conflicts, missing idempotency keys |
| `audit` | Finds critical actions with no logging — orders, payments, auth events, deletions |
| `integration` | Checks every third-party API call — validation, retry logic, rate limits, secret handling |
| `hotpath` | Identifies your most critical flow and obsessively checks every input, dependency, and assumption |
| `a11y` | Finds accessibility issues — ARIA gaps, keyboard navigation, focus management, contrast |
| `config` | Checks env var validation, hardcoded dev URLs, missing timeouts, unsafe feature flags |
| `migration` | Checks DB migrations for table locks, missing rollbacks, NOT NULL without defaults |
| `dependencies` | Scans for CVEs, deprecated packages, lockfile hygiene, devDep mix-ups |
| `all` | Runs everything. Full report by severity. Score at the end. |

---

## What it catches

Things that actually ship to production and become 2am bug tickets:

**A discount field accepts 150%** because the frontend validates 0–100 but the backend applies whatever the request body sends. One API call from Postman, one order at negative price, one angry finance team. Wingman finds the missing server-side clamp before it becomes a refund.

**A submit button stays enabled after click.** User double-taps on mobile, two orders created, one payment charged, duplicate shipment sent. Support ticket opened, order manually cancelled, customer already confused. Wingman flags the missing disabled state on the handler before your support queue does.

**`DELETE /api/users/:id` has no auth guard.** The route works perfectly — it just works for anyone who finds it. Every user account on your platform is one curl command away from deletion. Wingman checks every route for missing middleware, not just the ones you remembered to protect.

**The inventory service times out and the catch block returns `true`.** Out-of-stock item gets ordered, warehouse can't fulfill, customer waits two weeks to find out. Wingman reads what your catch block actually does — not just that it exists.

**`userId` comes from `req.body` instead of the JWT.** Any logged-in user passes someone else's ID in the payload and acts as them — reads their data, places orders on their account, changes their email. Wingman traces where identity is established at every layer, not just at login.

**A promo code field accepts empty string and the backend applies 100% discount.** No validation on either side for the empty case because both sides assumed the other handled it. Wingman maps what each layer actually validates and finds the gap in between.

---

## How it works

Wingman uses your AI tool's full codebase access — not just the file you have open. It thinks adversarially: given this code, how do I break it? It only flags real issues with actual file names and line numbers — no hypotheticals, no noise.

**Token-efficient by design.** Wingman's instructions are compressed to ~2,500 tokens per invocation — down from ~19,000 in earlier verbose versions. The AI uses its own domain knowledge for each check category rather than reading a wall of explicit instructions. Same coverage, 87% fewer prompt tokens burned on every call.

---

## Works with

- **Claude Code** — native slash command (`/wingman`)
- **Cursor** — always-on via `.cursorrules`
- **Windsurf** — always-on via `.windsurfrules`
- **Zed** — AI assistant context via `.zed/wingman.json`
- **ChatGPT** — paste into Custom GPT system prompt or My Instructions
- **Claude.ai** — paste into Project Instructions
- **Gemini** — paste as context at the start of your conversation
- **Any AI** — paste `wingman-prompt.md` as your system prompt

---

## Add your own subcommands

Every subcommand is defined in a single markdown or config file. Fork the repo, add behavior to the relevant file for your tool, and it becomes a new command. For Claude Code specifically: add a new `### subcommand-name` section to `claude-code/wingman.md` and it works immediately with no other changes.

---

## Contributing

Open an issue to suggest a new subcommand, or open a PR that adds the behavior to all tool files. Keep it tight — one focused behavior per subcommand, no filler.

---

## License

MIT — Shravani Kher
