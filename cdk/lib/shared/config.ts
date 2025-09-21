export interface EnvironmentConfig {
  account?: string;
  region: string;
  project: string;
  stage: string;
  
  // Environment-specific parameters
  topicNamespace: string;
  
  // ECS/Fargate parameters
  cpu?: number;
  memory?: number;
  maxContainerCpu?: number;
  maxContainerMemory?: number;
  
  // KSQLDB specific parameters
  heap?: string;
  rocksdbCache?: number;
  
  // Termination protection stages
  terminationProtectionEnabled: boolean;
  
  // VPC configuration
  vpc?: {
    ssmPath: string;
  };
  
  // IAM configuration
  iam?: {
    path: string;
    permissionsBoundaryArn: string;
  };
  
  // Alerts configuration
  alerts?: {
    slackWebhookSecret?: string;
    enableMskAlerts?: boolean;
    enableEcsAlerts?: boolean;
    emailAddresses?: string[];
  };
  
  // Logging configuration
  logging?: {
    retention: number;
  };
}

export const getEnvironmentConfig = (): EnvironmentConfig => {
  const stage = process.env.STAGE;
  const project = process.env.PROJECT || 'seatool';
  const region = process.env.REGION_A || 'us-east-1';
  
  // Validate required environment variables
  if (!stage) {
    throw new Error('STAGE environment variable is required for CDK deployment');
  }
  
  // Base configuration with common defaults
  const baseConfig: EnvironmentConfig = {
    region,
    project,
    stage,
    topicNamespace: `--${project}--${stage}--`,
    terminationProtectionEnabled: false,
    
    // VPC configuration
    vpc: {
      ssmPath: `/aws/reference/secretsmanager/${project}/default/vpc`
    },
    
    // IAM configuration
    iam: {
      path: '/delegatedadmin/developer/',
      permissionsBoundaryArn: `arn:aws:iam::\${aws:accountId}:policy/cms-cloud-admin/developer-boundary-policy`
    },
    
    // Alerts configuration defaults
    alerts: {
      slackWebhookSecret: `${project}/slack/webhook-url`,
      enableMskAlerts: true,
      enableEcsAlerts: true,
      emailAddresses: ["bpaige@gswell.com"]
    },
    
    // Logging configuration
    logging: {
      retention: 30
    }
  };
  
  // Environment-specific overrides
  switch (stage) {
    case 'master':
      return {
        ...baseConfig,
        topicNamespace: '',
        terminationProtectionEnabled: true,
        // Connector service params
        cpu: 256,
        maxContainerCpu: 128,
        memory: 2048,
        maxContainerMemory: 1024,
        // KSQLDB params
        heap: '-Xms7G -Xmx7G',
        rocksdbCache: 1073741824, // 1GB
      };
      
    case 'val':
      return {
        ...baseConfig,
        topicNamespace: '',
        terminationProtectionEnabled: true,
        // Connector service params
        cpu: 256,
        maxContainerCpu: 128,
        memory: 2048,
        maxContainerMemory: 1024,
        // KSQLDB params
        heap: '-Xms2G -Xmx2G',
        rocksdbCache: 536870912, // 512MB
      };
      
    case 'production':
      return {
        ...baseConfig,
        topicNamespace: '',
        terminationProtectionEnabled: true,
        // Connector service params
        cpu: 256,
        maxContainerCpu: 128,
        memory: 2048,
        maxContainerMemory: 1024,
        // KSQLDB params
        heap: '-Xms7G -Xmx7G',
        rocksdbCache: 1073741824, // 1GB
      };
      
    default: // dev and other environments
      return {
        ...baseConfig,
        // Connector service params
        cpu: 256,
        maxContainerCpu: 128,
        memory: 2048,
        maxContainerMemory: 1024,
        // KSQLDB params
        heap: '-Xms4G -Xmx4G',
        rocksdbCache: 2147483648, // 2GB
      };
  }
};

export const STACK_NAMES = {
  ALERTS: 'alerts',
  CONNECTOR: 'connector',
  DASHBOARD: 'dashboard',
  KSQLDB: 'ksqldb',
  DEBEZIUM: 'debezium',
  KSQLTHREE: 'ksqlthree',
} as const;

export const getStackName = (service: string, config: EnvironmentConfig): string => {
  return `${config.project}-cdk-${service}-${config.stage}`;
};

/**
 * Generate a namespaced resource name for CDK constructs
 * This ensures all resources are properly namespaced in shared AWS accounts
 */
export const getResourceName = (resourceType: string, resourceName: string, config: EnvironmentConfig): string => {
  return `${config.project}-${config.stage}-${resourceType}-${resourceName}`;
};

/**
 * Generate a CDK construct ID that is namespaced but CDK-friendly
 * CDK construct IDs don't need to be as descriptive as actual resource names
 */
export const getConstructId = (resourceType: string, resourceName: string, config: EnvironmentConfig): string => {
  // Use PascalCase for CDK construct IDs
  const capitalize = (str: string) => str.charAt(0).toUpperCase() + str.slice(1);
  const project = capitalize(config.project);
  const stage = capitalize(config.stage);
  const type = capitalize(resourceType);
  const name = capitalize(resourceName);
  
  return `${project}${stage}${type}${name}`;
};
