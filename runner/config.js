// Self-hosted Renovate runner config.

module.exports = {
	platform: "github",
	token: process.env.RENOVATE_TOKEN,
	gitAuthor: "Renovate Bot <renovate-bot@viewzenlabs.com>",
	repositories: require("./repositories.json"),
	baseBranches: ["feat/renovate-onboarding"],	// temporary
	onboarding: false,	// temporary — skip the "add config" onboarding PR and apply our config directly
	requireConfig: "optional",	// temporary
	hostRules: [
		{
			matchHost: "npmregistry.viewzenlabs.in",
			token: process.env.VIEWZEN_NPM_TOKEN,
		},
	],
	dryRun: process.env.RENOVATE_DRY_RUN === "true" ? "full" : null,
};
