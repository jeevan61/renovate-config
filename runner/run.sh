#!/usr/bin/env bash
# Runs self-hosted Renovate against the repos listed in repositories.json,
# using the official Renovate Docker image. Safe to run manually or from
# Jenkins/cron.
#
# Copy .env.template to .env and fill in the values, or export the same
# vars in your shell before running — either way works.
#
# Required env vars:
#   RENOVATE_TOKEN     - GitHub token/bot account with repo read/write access
# Optional env vars:
#   VIEWZEN_NPM_TOKEN  - private npm registry token, for resolving @viewzen/* packages
#   RENOVATE_DRY_RUN   - "true" to only log what would happen, no PRs opened (default: true)

set -euo pipefail
cd "$(dirname "$0")"

ENV_FILE_ARGS=()
if [ -f .env ]; then
	set -a
	# shellcheck disable=SC1091
	source .env
	set +a
	ENV_FILE_ARGS=(--env-file .env)
fi

: "${RENOVATE_TOKEN:?Set RENOVATE_TOKEN before running (in .env or exported)}"
: "${RENOVATE_DRY_RUN:=true}"
: "${LOG_LEVEL:=info}"

docker run --rm \
	"${ENV_FILE_ARGS[@]}" \
	-e RENOVATE_TOKEN="${RENOVATE_TOKEN}" \
	-e VIEWZEN_NPM_TOKEN="${VIEWZEN_NPM_TOKEN:-}" \
	-e RENOVATE_DRY_RUN="${RENOVATE_DRY_RUN}" \
	-e LOG_LEVEL="${LOG_LEVEL}" \
	-e RENOVATE_CONFIG_FILE=/usr/src/app/runner-config/config.js \
	-v "$(pwd)/config.js:/usr/src/app/runner-config/config.js:ro" \
	-v "$(pwd)/repositories.json:/usr/src/app/runner-config/repositories.json:ro" \
	renovate/renovate:latest
