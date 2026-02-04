# Backend Python

Python-specific practices for backend development.

## Type Hints

> Types are documentation that the tooling can verify.

- Use type hints for function signatures and class attributes
- Prefer `typing` module types (`list[str]`, `dict[str, int]`) over bare containers
- Use `Optional` explicitly when `None` is valid; avoid implicit `None` returns
- Run a type checker (mypy, pyright) in CI - hints without checking are just comments

## Virtual Environments & Dependencies

> Isolation prevents dependency hell.

- Always use a virtual environment - never install into system Python
- Define dependencies in `pyproject.toml` with pinned versions
- Separate dev dependencies from production dependencies
- Include Python version requirement in project metadata

## Error Handling

> Be specific about what you catch.

- Catch specific exceptions, not bare `except:` or `Exception`
- Use context managers (`with`) for resource cleanup
- Raise exceptions with meaningful messages; re-raise with `raise ... from err`
- Let unexpected exceptions propagate - don't hide bugs

## Project Structure

> Explicit is better than implicit.

- Use `src/` layout to prevent accidental local imports
- One package per concern; avoid circular imports
- Use `__init__.py` deliberately - explicit public API, not everything exported
- Keep entry points thin - put logic in importable modules for testability

## HTTP APIs

> Validate early, respond consistently.

- Use FastAPI for HTTP services - it provides automatic validation, OpenAPI docs, and async support
- Validate all inputs at the route boundary using Pydantic models
- Use semantic HTTP status codes: 200 for success, 201 for created, 400 for bad request, 404 for not found, 500 for server errors
- Return consistent error response structures with actionable messages
- Use dependency injection for shared resources (database connections, auth)
- Set appropriate Content-Type headers; prefer `application/json` for APIs
