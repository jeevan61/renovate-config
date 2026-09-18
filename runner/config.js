// Self-hosted Renovate runner config.


module.exports = {
	platform: "github",
	token: process.env.RENOVATE_TOKEN,
	gitAuthor: "Renovate Bot <renovate-bot@viewzenlabs.com>",
	repositories: require("./repositories.json"),

	onboarding: false,
	requireConfig: "optional",

	extends: ["config:recommended", "group:allNonMajor"],
	timezone: "Asia/Kolkata",

	baseBranchPatterns: ["develop"],

	schedule: ["at any time"],
	prConcurrentLimit: 10,
	vulnerabilityAlerts: {
		schedule: ["at any time"],
	},
	packageRules: [
		{
			description:
				"Major updates always need a manual look, so never auto-merge them. Each one gets its own PR, unless it's part of a related group (e.g. same monorepo), which still gets bundled automatically.",
			matchUpdateTypes: ["major"],
			automerge: false,
		},
	],

	hostRules: [
		{
			matchHost: "npmregistry.viewzenlabs.in",
			token: process.env.VIEWZEN_NPM_TOKEN,
		},
	],

	dryRun: process.env.RENOVATE_DRY_RUN === "true" ? "full" : null,
};
