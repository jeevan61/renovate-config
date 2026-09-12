// Self-hosted Renovate runner config.


module.exports = {
	platform: "github",
	token: process.env.RENOVATE_TOKEN,
	gitAuthor: "Renovate Bot <renovate-bot@viewzenlabs.com>",
	repositories: require("./repositories.json"),

	onboarding: false,
	requireConfig: "optional",

	extends: ["config:recommended"],
	timezone: "Asia/Kolkata",
	schedule: ["* * 1-7 1,4,7,10 *"],
	prConcurrentLimit: 10,
	prHourlyLimit: 3,
	vulnerabilityAlerts: {
		schedule: ["at any time"],
	},
	packageRules: [
		{
			description: "Group safe patch/minor updates into one PR",
			matchUpdateTypes: ["minor", "patch"],
			groupName: "minor + patch updates",
		},
		{
			description:
				"Major/breaking updates are never auto-merged. Unrelated majors stay as separate PRs by default; genuinely related packages (e.g. same monorepo) still group automatically via config:recommended.",
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
