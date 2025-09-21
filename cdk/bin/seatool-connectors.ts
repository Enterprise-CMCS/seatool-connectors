#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { getEnvironmentConfig } from '../lib/shared/config';
import { AlertsStack } from '../lib/stacks/alerts-stack';

const app = new cdk.App();

// Get environment configuration
const config = getEnvironmentConfig();

// Set up environment for all stacks
const env: cdk.Environment = {
  account: config.account || process.env.CDK_DEFAULT_ACCOUNT,
  region: config.region,
};

// Create the Alerts stack
const alertsStack = new AlertsStack(app, `${config.project}-cdk-alerts-${config.stage}`, {
  env,
  config,
  description: `Alerts infrastructure for ${config.project} ${config.stage} environment`,
});

// Add tags to all stacks
cdk.Tags.of(app).add('PROJECT', config.project);
cdk.Tags.of(app).add('STAGE', config.stage);
cdk.Tags.of(app).add('INFRASTRUCTURE', 'CDK');

// TODO: Add other stacks as they are implemented:
// - Dashboard Stack
// - Connector Stack  
// - Debezium Stack
// - KsqlDB Stack
// - KsqlThree Stack
