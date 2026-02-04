# Backend Go

Go-specific practices for backend development.

## Error Handling

> Errors are values - handle them explicitly.

- Always check returned errors; never use `_` to ignore them
- Wrap errors with context using `fmt.Errorf("doing x: %w", err)`
- Use sentinel errors or custom types for errors callers need to inspect
- Return early on errors to keep the happy path left-aligned

## Concurrency

> Don't communicate by sharing memory; share memory by communicating.

- Prefer channels for coordination, mutexes for state protection
- Always know which goroutine owns which data
- Use `context.Context` for cancellation and timeouts
- Don't start goroutines without knowing how they'll stop

## Project Structure

> A little copying is better than a little dependency.

- Follow standard layout: `cmd/`, `internal/`, `pkg/` where appropriate
- Keep packages small and focused; name them for what they provide
- Avoid `utils` or `common` packages - find a better home
- Use `internal/` to prevent unintended external imports

## Interfaces

> Accept interfaces, return structs.

- Define interfaces where they're used, not where they're implemented
- Keep interfaces small - one or two methods is often enough
- Let interfaces emerge from need, don't design them upfront
- Use interface composition to build larger contracts

## HTTP APIs

> Use Gin for HTTP services.

- Prefer Gin over net/http for APIs - it provides routing, middleware, and validation out of the box
- Use Gin's middleware chain for cross-cutting concerns (logging, auth, recovery)
- Leverage binding and validation tags for request parsing
- Group routes logically using `RouterGroup`
- Validate all inputs at the handler boundary - never trust client data
- Use semantic HTTP status codes: 200 for success, 201 for created, 400 for bad request, 404 for not found, 500 for server errors
- Return consistent error response structures with actionable messages
- Set appropriate Content-Type headers; prefer `application/json` for APIs
