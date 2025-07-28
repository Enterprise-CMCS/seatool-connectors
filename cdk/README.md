# Seatool Connectors CDK Infrastructure

This directory contains AWS CDK (Cloud Development Kit) infrastructure code for the Seatool Connectors project. The CDK code is being used to replace the existing Serverless Framework stacks with native AWS CloudFormation through CDK.

## Architecture

The infrastructure consists of several stacks:

- **Alerts Stack**: SNS topics and CloudWatch alarms for monitoring and alerting

Additional stacks will be added as they are migrated from Serverless Framework:

- Dashboard Stack (planned)
- Connector Stack (planned)  
- Debezium Stack (planned)
- KsqlDB Stack (planned)
- KsqlThree Stack (planned)

## Prerequisites

- Node.js v20.17.0 (see `.nvmrc`)
- Yarn package manager
- AWS CLI configured with appropriate credentials
- CDK CLI: `npm install -g aws-cdk@2.179.0`

## Bootstrap Namespacing

This CDK project uses a custom bootstrap qualifier (`seatool`) to namespace its bootstrap resources. This allows multiple CDK projects to coexist in the same AWS account/region without conflicts.

The bootstrap resources are created with names like:
- S3 Bucket: `cdk-seatool-assets-{account}-{region}`
- IAM Roles: `cdk-seatool-cfn-exec-role-{account}-{region}`
- SSM Parameter: `/cdk-bootstrap/seatool/version`

Other CDK projects should use their own unique qualifiers to avoid resource conflicts.

## Local Development

### Setup

```bash
# Install dependencies
yarn install

# Build the CDK app
yarn build

# Synthesize CloudFormation templates
yarn synth
```

### Configuration

The CDK app uses environment variables to configure deployments:

- `STAGE`: The deployment stage (dev, val, master, production)
- `PROJECT`: The project name (defaults to 'seatool')
- `REGION_A`: The AWS region (defaults to 'us-east-1')

### Local Deployment

```bash
# Install CDK CLI globally
npm install -g aws-cdk@2.179.0

# Set environment variables
export STAGE=dev
export PROJECT=seatool
export REGION_A=us-east-1

# Install dependencies and build
yarn install
yarn cdk:install  
yarn cdk:build

# Bootstrap CDK (first time only)
cd cdk && cdk bootstrap --qualifier seatool

# See what will be deployed
yarn cdk:diff

# Deploy the infrastructure
yarn cdk:deploy

# Destroy the infrastructure
yarn cdk:destroy
```

## GitHub Actions Deployment

The project includes GitHub Actions workflows for automated deployment:

### Deploy Workflow (`.github/workflows/deploy-cdk.yml`)

Automatically triggered on:

- Push to any branch (except `skipci*` branches) when CDK files change
- Manual dispatch with custom stage parameter

The workflow:

1. Validates the stage name
2. Installs dependencies
3. Builds the CDK app
4. Bootstraps CDK if needed
5. Shows deployment diff
6. Deploys the infrastructure
7. Runs security scans with cfn_nag
8. Sends notifications on failure

### Destroy Workflow (`.github/workflows/destroy-cdk.yml`)

Manual workflow for destroying infrastructure:

1. Builds and destroys the CDK stacks
2. Cleans up GitHub environments

## Environment Configuration

Different environments have different configurations:

### Development (`dev`, default)

- Basic resource allocation
- No termination protection
- Includes topic namespace for isolation

### Validation (`val`)

- Optimized for light workloads
- Termination protection enabled
- No topic namespace

### Master/Production (`master`, `production`)

- Full production resources
- Termination protection enabled
- No topic namespace

## Stack Configuration

Each stack is configured through the shared configuration system in `lib/shared/config.ts`. The configuration includes:

- **VPC Settings**: SSM path for VPC configuration
- **IAM Settings**: Permission boundaries and paths
- **Alerts Settings**: Slack webhooks, email addresses, monitoring flags
- **Logging Settings**: CloudWatch log retention
- **Resource Settings**: CPU, memory, and other resource allocations

## SSM Parameters

The CDK app uses AWS Systems Manager Parameter Store for cross-stack communication and configuration sharing. See `lib/shared/ssm-parameters.ts` for parameter management utilities.

## Troubleshooting

### Common Issues

1. **Bootstrap Required**: If you see bootstrap errors, run `yarn cdk bootstrap`
2. **Permission Errors**: Ensure your AWS credentials have sufficient permissions
3. **Region Mismatch**: Verify `REGION_A` environment variable matches your AWS profile region

### Useful Commands

```bash
# List all stacks
cd cdk && cdk list

# Show diff for all stacks
yarn cdk:diff

# Deploy specific stack
cd cdk && cdk deploy seatool-cdk-alerts-dev

# Destroy specific stack
cd cdk && cdk destroy seatool-cdk-alerts-dev

# Synthesize templates to file
cd cdk && cdk synth --output cdk.out

# Using root package scripts (recommended)
yarn cdk:build
yarn cdk:synth  
yarn cdk:deploy
yarn cdk:destroy
```
