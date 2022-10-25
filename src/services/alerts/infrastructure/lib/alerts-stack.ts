import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as sns from "aws-cdk-lib/aws-sns";
import * as iam from "aws-cdk-lib/aws-iam";

export class AlertsStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const topic = new sns.Topic(this, "AlertsTopic", {
      topicName: `AlertsTopic-${props?.stackName}-${id}`,
    });

    const topicPolicy = new sns.TopicPolicy(this, "AlertsTopicPolicy", {
      topics: [topic],
    });

    topicPolicy.document.addStatements(
      new iam.PolicyStatement({
        actions: ["sns:Publish"],
        principals: [new iam.AnyPrincipal()],
        resources: [topic.topicArn],
      })
    );

    new cdk.CfnOutput(this, "topicArn", {
      value: topic.topicArn,
    });
  }
}
