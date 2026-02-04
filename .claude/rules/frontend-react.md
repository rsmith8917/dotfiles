# Frontend React

React-specific practices for frontend development.

## Component Design

> Components should do one thing well.

- Prefer composition over props for flexibility
- Keep components small - if it's hard to name, it's doing too much
- Separate presentational components from those with business logic
- Co-locate related files (component, styles, tests) in the same folder

## State Management

> State should live as close to where it's used as possible.

- Start with local state; lift only when siblings need to share
- Use context for truly global concerns (theme, auth, locale)
- Derive state where possible - don't sync what you can compute
- External stores (Redux, Zustand) for complex cross-cutting state only

## Effects & Data Fetching

> Effects are for synchronizing with external systems, not for reacting to state.

- Keep effects focused - one effect per concern
- Always specify dependency arrays accurately; don't lie to React
- Use cleanup functions to prevent memory leaks and race conditions
- Prefer data-fetching libraries (React Query, SWR) over raw `useEffect`

## Styling

> Styles should be predictable and scoped.

- Co-locate styles with components to ease maintenance
- Use a consistent approach across the project (CSS modules, styled-components, Tailwind)
- Avoid global styles except for true globals (resets, typography)
- Prefer design tokens/variables over hardcoded values
