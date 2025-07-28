import * as ssm from 'aws-cdk-lib/aws-ssm';
import { Construct } from 'constructs';
import { EnvironmentConfig } from './config';

export class SsmParameters {
  /**
   * Get parameter path for this environment
   */
  static getParameterPath(config: EnvironmentConfig, parameterName: string): string {
    return `/${config.project}/${config.stage}/${parameterName}`;
  }

  /**
   * Get parameter value from SSM
   */
  static getParameter(scope: Construct, config: EnvironmentConfig, parameterName: string, defaultValue?: string): string {
    const parameterPath = this.getParameterPath(config, parameterName);
    
    try {
      return ssm.StringParameter.valueFromLookup(scope, parameterPath);
    } catch (error) {
      if (defaultValue !== undefined) {
        return defaultValue;
      }
      throw new Error(`Parameter ${parameterPath} not found and no default value provided`);
    }
  }

  /**
   * Create a new SSM parameter
   */
  static createParameter(
    scope: Construct, 
    id: string,
    config: EnvironmentConfig, 
    parameterName: string, 
    value: string,
    description?: string
  ): ssm.StringParameter {
    const parameterPath = this.getParameterPath(config, parameterName);
    
    return new ssm.StringParameter(scope, id, {
      parameterName: parameterPath,
      stringValue: value,
      description: description || `${parameterName} for ${config.project}-${config.stage}`,
      tier: ssm.ParameterTier.STANDARD,
    });
  }

  /**
   * Common parameters used across services
   */
  static getCommonParameters(scope: Construct, config: EnvironmentConfig) {
    return {
      // VPC and networking parameters
      vpcId: this.getParameter(scope, config, 'vpcId'),
      privateSubnets: this.getParameter(scope, config, 'privateSubnets'),
      publicSubnets: this.getParameter(scope, config, 'publicSubnets'),
      
      // Database parameters
      brokerString: this.getParameter(scope, config, 'brokerString'),
      
      // Topic ARNs (these will be populated by the alerts stack)
      ecsFailureTopicArn: this.getParameter(scope, config, 'ecsFailureTopicArn', ''),
      
      // KMS Keys
      kmsKeyId: this.getParameter(scope, config, 'kmsKeyId', ''),
    };
  }

  /**
   * Export parameter for use by other stacks
   */
  static exportParameter(
    scope: Construct,
    id: string,
    config: EnvironmentConfig,
    parameterName: string,
    value: string
  ): ssm.StringParameter {
    return this.createParameter(scope, id, config, parameterName, value);
  }
}
