# DevOps Capstone Project

[![CI Build](https://github.com/bestbeet/devops-capstone-project/actions/workflows/ci-build.yaml/badge.svg)](https://github.com/bestbeet/devops-capstone-project/actions/workflows/ci-build.yaml)

Accounts REST API microservice built with Flask, SQLAlchemy and PostgreSQL for the IBM DevOps Capstone assignment.

## Endpoints

| Method | Path | Description |
| --- | --- | --- |
| GET | `/` | Service information |
| GET | `/health` | Health check |
| POST | `/accounts` | Create an account |
| GET | `/accounts` | List accounts (optional `?name=` filter) |
| GET | `/accounts/<id>` | Read an account |
| PUT | `/accounts/<id>` | Update an account |
| DELETE | `/accounts/<id>` | Delete an account |

## Development

Use Python 3.9 to match the capstone's legacy `nose` test runner.

```bash
python3.9 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
make db
make tests
make run
```

Requires Docker for `make db`. `make run` uses port 8000 by default (see `.flaskenv`).

## Verification

```bash
make lint
make tests
curl http://localhost:8000/health
```

## CI

The workflow at [ci-build.yaml](.github/workflows/ci-build.yaml) checks out code, installs dependencies, runs Flake8, and then runs unit tests using `nosetests` with a PostgreSQL service.

> Confirm the badge indicates a successful build before submitting Task 1. A badge alone is not proof of success.

## User stories

See [user-story.md](user-story.md) and [GitHub Issues](https://github.com/bestbeet/devops-capstone-project/issues).
