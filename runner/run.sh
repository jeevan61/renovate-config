#!/usr/bin/env bash


set -euo pipefail
cd "$(dirname "$0")"

ENV_FILE_ARGS=()
if [ -f .env ]; then
	set -a
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
