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

docker run --rm \
	"${ENV_FILE_ARGS[@]}" \
	-e RENOVATE_TOKEN="${RENOVATE_TOKEN}" \
	-e VIEWZEN_NPM_TOKEN="${VIEWZEN_NPM_TOKEN:-}" \
	-e RENOVATE_DRY_RUN="${RENOVATE_DRY_RUN}" \
	-v "$(pwd)/config.js:/usr/src/app/config.js:ro" \
	renovate/renovate:latest
