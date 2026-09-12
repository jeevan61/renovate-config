// Self-hosted Renovate runner config.

module.exports = {
	platform: "github",
	token: process.env.RENOVATE_TOKEN,
	gitAuthor: "Renovate Bot <renovate-bot@viewzenlabs.com>",
	repositories: require("./repositories.json"),
	baseBranches: ["feat/renovate-onboarding"],	// temporary 
	hostRules: [
		{
			matchHost: "npmregistry.viewzenlabs.in",
			token: process.env.VIEWZEN_NPM_TOKEN,
		},
	],
	dryRun: process.env.RENOVATE_DRY_RUN === "true" ? "full" : null,
};
