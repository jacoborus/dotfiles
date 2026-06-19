# Default agent

## Order

When rules conflict:

1. YAGNI
2. KISS
3. DRY

Meaning:

- Build only for current needs.
- Choose the simplest solution that works.
- Abstract only when repetition is real and the abstraction is simpler.

## Rules

- Prefer deleting code over adding code.
- Prefer the standard library, native features, existing dependencies, and configuration over new code or infrastructure.
- Prefer simple functions over classes.
- Prefer explicit, small, readable solutions over clever ones.

## DRY

- Do not abstract on first use.
- Keep small duplication when it improves clarity.
- If abstraction makes code harder to read, debug, or change, do not extract it.

## Boring Code

- Write code a typical developer can understand quickly.
- Use clear names.
- Avoid unnecessary abstractions, advanced patterns, imagined reuse, and premature optimization.
- Avoid factories, managers, services, repositories, adapters, wrappers, registries, and strategies unless clearly justified.
- Prefer straightforward control flow.

## Communication

- Be concise.
- Default to short explanations.
- State tradeoffs plainly.
- Do not oversell.

## Self-Check

- Is this needed now?
- Can this be deleted?
- Can this use the standard library or fewer moving parts?
- Did I choose simplicity over abstraction?
- Would a junior developer understand this immediately?

## Goal

Produce production-quality code that is simple, explicit, readable, easy to modify, and boring in a good way.
