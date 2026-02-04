# Software Development Standards

Universal practices for building maintainable, reliable software.

## Testing

> Code should be verifiable.

- Write tests for behavior, not implementation details
- Test edge cases and error paths, not just happy paths
- Prefer fast, isolated unit tests; use integration tests at boundaries
- Tests are documentation - they show how code is meant to be used

## Version Control

> History should tell a story.

- Make commits atomic and focused on a single change
- Write commit messages that explain why, not just what
- Keep the main branch deployable
- Branch for features, merge when complete and tested

## Documentation

> Document what code cannot express.

- Document public APIs and their contracts
- Explain "why" in comments, not "what" (code shows what)
- Keep docs close to code so they stay in sync
- A README should get someone running in minutes

## Naming & Clarity

> Code is read more than written.

- Names should reveal intention - avoid cryptic abbreviations
- Functions should do what their name suggests, nothing more
- Prefer explicit over clever
- If you need a comment to explain what, rename instead

## Error Handling

> Errors are expected, not exceptional.

- Handle errors explicitly at appropriate boundaries
- Fail fast - surface problems early rather than propagating bad state
- Provide context in error messages for debugging
- Don't swallow errors silently

## Simplicity

> The best code is code you don't write.

- YAGNI - don't build for hypothetical requirements
- Prefer duplication over the wrong abstraction
- Delete dead code; version control remembers
- Wait for three similar instances before abstracting

## Modularity & Testability

> Dependencies should be explicit and injectable.

- Inject dependencies rather than hardcoding them
- Define interfaces/contracts for external dependencies (databases, APIs, file systems)
- Depend on abstractions, not concrete implementations - this enables testing and substitution
- Keep units small with single responsibilities
- If it's hard to test, it's probably too coupled

## Observability

> Production code must be understandable at runtime.

- Use structured logging with consistent fields
- Include correlation/trace IDs for request tracking
- Log at appropriate levels (error, warn, info, debug)
- Surface key metrics for health and performance

## Language & Framework Rules

Apply these additional rules based on the project's stack:

- [Backend Go](rules/backend-go.md) - Error handling, concurrency, project structure, interfaces
- [Backend Python](rules/backend-python.md) - Type hints, dependencies, error handling, project structure
- [Frontend React](rules/frontend-react.md) - Component design, state management, effects, styling
