# renovate-config

Self-hosted Renovate setup — automates dependency update PRs across ViewzenLabs repos.

## Prerequesite

-   Docker
-   A GitHub token (repo read/write access)
-   Private npm registry token, for repos using `@viewzen/*` packages

### Local Development

- Copy `.env.template` and create `.env` file inside `runner/`

    ```sh
    cd runner
    cp .env.template .env
    ```

- Fill in `RENOVATE_TOKEN` and `VIEWZEN_NPM_TOKEN` in `.env`

- Leave `RENOVATE_DRY_RUN="true"` while testing — logs what it would do, opens no PRs

- Run it

    ```sh
    ./run.sh
    ```

### Onboarding a repo

- Add the repo name to `runner/repositories.json` 
- Run a dry run first, then set `RENOVATE_DRY_RUN="false"` once confirmed

#### Reference

- [Renovate self-hosted config options](https://docs.renovatebot.com/self-hosted-configuration/)
- [Renovate config presets](https://docs.renovatebot.com/config-presets/)
