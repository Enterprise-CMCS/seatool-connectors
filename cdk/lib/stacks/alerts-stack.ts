import * as cdk from 'aws-cdk-lib';
import * as sns from 'aws-cdk-lib/aws-sns';
import * as kms from 'aws-cdk-lib/aws-kms';
import * as iam from 'aws-cdk-lib/aws-iam';
import { Construct } from 'constructs';
import { EnvironmentConfig, getStackName, getResourceName, getConstructId } from '../shared/config';
import { SsmParameters } from '../shared/ssm-parameters';

export interface AlertsStackProps extends cdk.StackProps {
  config: EnvironmentConfig;
}

export class AlertsStack extends cdk.Stack {
  public readonly ecsFailureTopic: sns.Topic;
  public readonly kmsKey: kms.Key;

  constructor(scope: Construct, id: string, props: AlertsStackProps) {
    super(scope, id, props);

    const { config } = props;

    // Apply termination protection for production stages
    if (config.terminationProtectionEnabled) {
      this.terminationProtection = true;
    }

    // Add stack tags
    cdk.Tags.of(this).add('PROJECT', config.project);
    cdk.Tags.of(this).add('SERVICE', getStackName('alerts', config));

    // Create KMS key for SNS
    this.kmsKey = new kms.Key(this, getConstructId('kms', 'alertsSns', config), {
      enableKeyRotation: true,
      description: `KMS key for SNS topics in ${config.project}-${config.stage}`,
      alias: getResourceName('kms', 'alerts-sns', config),
      policy: new iam.PolicyDocument({
        statements: [
          // Allow access for Root User
          new iam.PolicyStatement({
            sid: 'Allow access for Root User',
            effect: iam.Effect.ALLOW,
            principals: [new iam.AccountRootPrincipal()],
            actions: ['kms:*'],
            resources: ['*'],
          }),
          // Allow access for Key User (SNS Service Principal)
          new iam.PolicyStatement({
            sid: 'Allow access for Key User (SNS Service Principal)',
            effect: iam.Effect.ALLOW,
            principals: [new iam.ServicePrincipal('sns.amazonaws.com')],
            actions: [
              'kms:GenerateDataKey',
              'kms:Decrypt',
            ],
            resources: ['*'],
          }),
          // Allow CloudWatch events to use the key
          new iam.PolicyStatement({
            sid: 'Allow CloudWatch events to use the key',
            effect: iam.Effect.ALLOW,
            principals: [new iam.ServicePrincipal('events.amazonaws.com')],
            actions: [
              'kms:Decrypt',
              'kms:GenerateDataKey',
            ],
            resources: ['*'],
          }),
          // Allow CloudWatch for CMK
          new iam.PolicyStatement({
            sid: 'Allow CloudWatch for CMK',
            effect: iam.Effect.ALLOW,
            principals: [new iam.ServicePrincipal('cloudwatch.amazonaws.com')],
            actions: [
              'kms:Decrypt',
              'kms:GenerateDataKey*',
            ],
            resources: ['*'],
          }),
        ],
      }),
    });

    // Create SNS topic for ECS task failures
    this.ecsFailureTopic = new sns.Topic(this, getConstructId('sns', 'ecsFailure', config), {
      topicName: getResourceName('alerts', 'ecs-failure', config),
      masterKey: this.kmsKey,
    });

    // Add topic policy to allow EventBridge and CloudWatch to publish
    this.ecsFailureTopic.addToResourcePolicy(
      new iam.PolicyStatement({
        effect: iam.Effect.ALLOW,
        principals: [
          new iam.ServicePrincipal('events.amazonaws.com'),
          new iam.ServicePrincipal('cloudwatch.amazonaws.com'),
        ],
        actions: ['sns:Publish'],
        resources: [this.ecsFailureTopic.topicArn],
      })
    );

    // Export the topic ARN as an SSM parameter for other stacks to use
    SsmParameters.exportParameter(
      this,
      getConstructId('ssm', 'ecsFailureTopicArn', config),
      config,
      'ecsFailureTopicArn',
      this.ecsFailureTopic.topicArn
    );

    // Export KMS key ID as an SSM parameter
    SsmParameters.exportParameter(
      this,
      getConstructId('ssm', 'kmsKeyId', config),
      config,
      'kmsKeyId',
      this.kmsKey.keyId
    );

    // CloudFormation outputs
    new cdk.CfnOutput(this, getConstructId('output', 'ecsFailureTopicArn', config), {
      description: 'ECS Failure SNS topic ARN',
      value: this.ecsFailureTopic.topicArn,
      exportName: `${getStackName('alerts', config)}-ECSFailureTopicArn`,
    });

    new cdk.CfnOutput(this, getConstructId('output', 'kmsKeyId', config), {
      description: 'KMS Key ID for SNS encryption',
      value: this.kmsKey.keyId,
      exportName: `${getStackName('alerts', config)}-KmsKeyId`,
    });
  }
}
