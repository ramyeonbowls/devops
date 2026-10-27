# Repository Guidelines

## Project Structure & Module Organization

This repository contains the LogPulse application. The React and TypeScript frontend is in `logs/`: `src/components/` holds UI components, `src/services/` contains API access, and `src/types/` defines shared frontend types. The Go HTTP service is in `logs/backend/`; its API, SQLite persistence, and SSH/SFTP integration live in `internal/app/`, with startup in `main.go`. Root-level `docker-compose.yml`, `Dockerfile.frontend`, and `Caddyfile` configure deployment. Keep changes within the relevant frontend or backend area and avoid committing generated binaries, build output, or local database files.

## Build, Test, and Development Commands

Run frontend commands from `logs/`:

- `npm run dev` starts the development server.
- `npm run build` creates the production frontend build.
- `npm run lint` runs TypeScript checks (`tsc --noEmit`).
- `npm start` serves the production build locally.

Run backend commands from `logs/backend/`:

- `make run` starts the Go service (default port 8080; override with `PORT=...`).
- `make build` builds the service binary under `bin/`.
- `make test` runs Go tests across packages with `go test -v ./...`.

## Coding Style & Naming Conventions

Use two spaces for TypeScript/TSX indentation and keep components in PascalCase (for example, `LogStreamViewer.tsx`). Use camelCase for functions, variables, and properties. Keep API and data types in the existing `services/` and `types/` locations. Format Go changes with `gofmt`; use exported PascalCase and unexported camelCase names in line with Go conventions. Follow nearby code patterns and avoid introducing dependencies for small utilities.

## Testing Guidelines

There is no configured frontend test runner. Run `npm run lint` and `npm run build` for frontend changes. Add Go tests alongside the package they cover using `*_test.go` filenames, then run `make test` from `logs/backend/`. For API behavior changes, check the matching frontend service and backend handler together.

## Commit & Pull Request Guidelines

Recent commits use Conventional Commit prefixes such as `feat:`, `fix:`, and `docs:`; include a scope when useful, for example `feat(backend): add session revocation`. Pull requests should explain the behavior changed, list relevant checks, link related issues, and include screenshots for visible UI changes. Call out configuration or deployment changes explicitly.

## Security & Configuration Tips

Use the root `.env.example` as a template for Go deployment configuration; keep local values in the root `.env` file. Keep credentials and machine-specific values in local environment files; never commit secrets, production connection details, or populated runtime data from `logs/data/`.
