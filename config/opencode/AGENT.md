# Agent Instructions

## Self-Improvement Protocol

When you learn something new or valuable during a session:
1. Update this file with the new knowledge
2. Organize learnings by topic/domain
3. Be concise - no fluff or unnecessary commentary
4. Focus on actionable patterns and anti-patterns
5. Keep instructions codebase-independent - focus on tools, workflows, and user preferences

## Communication Style

- Skip acknowledgements like "You're absolutely right!"
- Be direct and concise

## Intellectual Honesty

- NEVER fabricate data, statistics, or benchmark results
- If you don't have data to back up a claim, don't make the claim
- When comparing alternatives, only include metrics you have actually measured or can cite
- Say "I don't know" or "I haven't measured this" rather than guessing
- Qualitative comparisons without data are lies dressed up as analysis
- DO proactively suggest measurements: "Maybe we should benchmark X?" or "Should we measure Y before deciding?"
- Challenge assumptions - if user claims something is faster/better, ask if there's data or offer to measure it

## Code Style

- No useless comments - user can read code
- Comments ARE acceptable when code is not obvious
- Delete dead code instead of commenting it out
- Never use `tap` - expand the code instead
- Use `attr_reader(:name)` with parentheses, not `attr_reader :name`
- Prefer `if`/`else` over ternary operators for assignments

## File System

- NEVER use `/tmp` for temporary files — always use `./tmp` (project-local) instead

## Git Workflow (Graphite)

- Use `gt submit` to push branches and update PRs
- Use `gt ss` as shorthand for `gt submit --stack`
- Never use `git push --force` - always use gt commands
- Use `git commit --amend` for incorporating fixes into existing commits

### Commit Message Style

User prefers structured commit messages with:
- Title: `[project/area] Short description of what this does`
- Body explains WHY, not just what
- Do NOT list individual files changed - the user can see that via `git show` or GitHub's "files changed" tab
- Use markdown headers (`##`) to organize sections
- Include code examples in fenced blocks when helpful
- For benchmarks: summarize results, optionally include full code in `<details>` tag

Example:
```
[sfp/serialization] Add serialization_skip annotation for non-serializable messages

Adds a new `serialization_skip` MessageOption annotation that allows marking
messages as non-serializable. When set to true:

- Skips generating `to_msgpack_ext` and `from_msgpack_ext` methods
- Skips generating `SCHEMA_HASH` constant
- Excludes the message from MsgpackFactory registration
- Raises an error if a serializable message references an unserializable one

## Usage

\`\`\`protobuf
message Unserializable {
  option (shopify.storefront.experimental.serialization_skip) = true;
}
\`\`\`
```

## Shopify Development

### Dev Commands

- Use `dev` for project commands: `dev up`, `dev test`, `dev server`, etc.
- In some environments, prefix with `shadowenv exec -- /opt/dev/bin/dev`
- For test filtering by name: use `--name=/pattern/` NOT `::test_name` syntax

### Completion Workflow

NEVER claim work is done without running these checks:
1. Run tests: `dev test` (on modified files or specific tests)
2. Run type checking: `dev tc`
3. Run linting: `dev style --include-branch-commits`

Only after all three pass can work be considered complete.

## Ruby/Async Patterns

### Providing Async Context in Tests

When tests fail with "No async task available!", wrap test execution in `Sync` block:

```ruby
class TestCase < BaseTestClass
  def run
    Sync { super }
  end
end
```

This provides async context for `Future#await` operations throughout test lifecycle.

When adding async wrapper to base class, remove redundant overrides from child classes.
