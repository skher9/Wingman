# wingman

**Your personal QA wingman. Finds the bugs before anyone else does.**

You finish building a feature. You think it works. You run `/wingman` — and it goes through your entire codebase thinking like a paranoid senior QA engineer who has seen everything go wrong. It finds the negative number that breaks your input field. The missing auth guard on that one DELETE route. The race condition from double-clicking the submit button. The third-party API call with no timeout that will hang your entire checkout flow at 2am. All the things you missed because you were thinking about making it work, not making it break. Privately. Before you push. Before anyone raises a bug ticket. That's wingman.

---

## Install

**Mac / Linux**
```bash
curl -s https://raw.githubusercontent.com/YOUR_USERNAME/wingman/main/install.sh | bash
```

**Windows**
```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/wingman/main/install.ps1 | iex
```

Then open Claude Code in your project and type `/wingman all`.

---

## Commands

| Command | What it does |
|---|---|
| `/wingman nitpick` | Finds basic bugs in the feature you just built — inputs, null handling, missing branches |
| `/wingman crossfire` | Reads your git diff and maps every file, module, and API that depends on what changed |
| `/wingman scenario` | Traces complete user journeys through the codebase — finds where they silently break |
| `/wingman regression` | Finds every test, module, and API consumer at risk from your recent changes |
| `/wingman security` | Checks auth gaps, missing permission guards, PII leaks, unsanitized inputs, hardcoded secrets |
| `/wingman performance` | Finds N+1 queries, full table scans, unnecessary re-renders, unclean listeners |
| `/wingman dataflow` | Traces data through layers — type mismatches, null propagation, unsafe mutations |
| `/wingman fallback` | Finds every failure point with no fallback — no catch, no retry, no timeout |
| `/wingman edge` | Tests every input at zero, null, empty, max, min, duplicates — semantically, not generically |
| `/wingman state` | Maps the state machine — invalid transitions, crash-mid-flow gaps, impossible states |
| `/wingman concurrent` | Finds race conditions — double submit, multi-tab conflicts, missing idempotency keys |
| `/wingman audit` | Finds critical actions with no logging — orders, payments, auth events, deletions |
| `/wingman integration` | Checks every third-party API call — validation, retry logic, rate limits, secret handling |
| `/wingman hotpath` | Identifies your most critical flow and obsessively checks every input, dependency, and assumption |
| `/wingman all` | Runs everything. Full report by severity. Score at the end. |

---

## What it catches

Things that actually ship to production and become bug tickets:

- **Discount field accepts 150%** — frontend validates 0–100, but the backend applies whatever it receives. Wingman finds the missing server-side clamp.

- **Submit button not disabled after click** — user double-clicks, two orders created, one payment taken, support ticket opened. Wingman flags the missing debounce/disable on the submit handler.

- **`DELETE /api/users/:id` has no auth guard** — anyone who finds the endpoint can delete any user account. Wingman checks every route for missing middleware.

- **Inventory check swallows errors** — if the inventory service times out, the catch block returns `true` and the order goes through on out-of-stock items. Wingman reads the actual catch logic, not just that it exists.

- **User ID taken from request body instead of JWT** — any authenticated user can pass any `userId` in the payload and act as that user. Wingman traces where identity comes from at each layer.

---

## How it works

Wingman uses Claude Code's full codebase access — not just the file you have open. It thinks adversarially: given this code, how do I break it? It only flags real issues with actual file names and line numbers — no hypotheticals, no noise.

---

## Why it's different

Every other linter or AI review tool looks at one file at a time. Wingman knows your entire codebase — frontend, backend, database schema, API contracts, git history — and connects the dots across all of it. It knows if your frontend validates something your backend doesn't. It knows if the change you made to the auth middleware will break your payment flow three layers down. That cross-codebase context is what makes it actually useful.

---

## Add your own commands

Every subcommand is just a markdown file in `.claude/commands/`. Fork the repo, drop a new `.md` file in that folder with whatever behavior you want, and it becomes a new slash command in Claude Code instantly.

---

## Contributing

Open an issue to suggest a new subcommand, or PR a new command file directly. Keep it tight — one focused behavior per command, no filler.

---

## License

MIT
