import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Construct } from 'constructs';
import { EnvironmentConfig, getConstructId } from './config';

export interface VpcResources {
  vpc: ec2.IVpc;
  privateSubnets: ec2.ISubnet[];
  publicSubnets: ec2.ISubnet[];
  databaseSubnets?: ec2.ISubnet[];
}

export class VpcLookup {
  private static cachedVpc: VpcResources | undefined;

  static getVpc(scope: Construct, config: EnvironmentConfig): VpcResources {
    if (this.cachedVpc) {
      return this.cachedVpc;
    }

    // Look up the existing VPC by tags or name
    // This follows the same pattern as the Serverless configuration
    const vpc = ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'main', config), {
      // Look up VPC by tag or use default VPC
      // Adjust these tags based on your actual VPC setup
      tags: {
        Name: `${config.project}-vpc-${config.stage}`,
      },
    });

    // Look up subnets by tags
    const privateSubnets = [
      ec2.Subnet.fromSubnetId(scope, getConstructId('subnet', 'private1', config), 
        ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'subnetsLookup1', config), { isDefault: false }).privateSubnets[0]?.subnetId || ''
      ),
      ec2.Subnet.fromSubnetId(scope, getConstructId('subnet', 'private2', config), 
        ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'subnetsLookup2', config), { isDefault: false }).privateSubnets[1]?.subnetId || ''
      ),
    ];

    const publicSubnets = [
      ec2.Subnet.fromSubnetId(scope, getConstructId('subnet', 'public1', config), 
        ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'publicSubnetsLookup1', config), { isDefault: false }).publicSubnets[0]?.subnetId || ''
      ),
      ec2.Subnet.fromSubnetId(scope, getConstructId('subnet', 'public2', config), 
        ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'publicSubnetsLookup2', config), { isDefault: false }).publicSubnets[1]?.subnetId || ''
      ),
    ];

    this.cachedVpc = {
      vpc,
      privateSubnets,
      publicSubnets,
    };

    return this.cachedVpc;
  }

  // Simplified version that uses the default VPC for now
  // This can be updated once we know the exact VPC configuration
  static getDefaultVpc(scope: Construct): VpcResources {
    if (this.cachedVpc) {
      return this.cachedVpc;
    }

    const vpc = ec2.Vpc.fromLookup(scope, getConstructId('vpc', 'default', { project: 'shared', stage: 'default' } as EnvironmentConfig), {
      isDefault: true,
    });

    this.cachedVpc = {
      vpc,
      privateSubnets: vpc.privateSubnets,
      publicSubnets: vpc.publicSubnets,
    };

    return this.cachedVpc;
  }
}
