## Learned User Preferences

- Use CMS Enterprise Jira at `https://jiraent.cms.gov` and Confluence at `https://confluenceent.cms.gov`; do not use `qmacbis.atlassian.net` for CMS work items.
- Jira and Confluence credentials are in `~/.zshrc` (`JIRA_TOKEN`, `CONFLUENCE_TOKEN`); source it before API calls.
- Present Jira ticket comments and status changes for approval before posting.
- For dependency reinstalls, run a single root `yarn install` for workspace packages; `src/services/.oidc` is outside workspaces and needs its own install.

## Learned Workspace Facts

- Production AWS profile is `bigmac-prod` in `us-east-1` for ECS and CloudWatch checks.
- Yarn v1 monorepo: workspaces under `src/libs` and `src/services/*`; dependencies hoist to root `node_modules`.
- Active ECS services include connector, debezium, ksqldb, and ksqlthree; legacy ksqlom/ksqlomcd stacks were decommissioned.
- Jira project for this work is OY2; GitHub repo is `Enterprise-CMCS/seatool-connectors`.
