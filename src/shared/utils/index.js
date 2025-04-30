/**
 * Common utilities for seatool-connectors
 * 
 * This file exports all utility functions from the shared modules to provide
 * a single import location for other services.
 */

export * from './errorHandling.js';
export * from './s3Utils.js';

// Constants and configurations that might be used across services
export const DEFAULT_RETRY_CONFIG = {
  maxRetries: 10,
  retryDelay: 10000, // 10 seconds
  retryCondition: (error) => {
    // Default retry condition: retry on network errors or throttling
    if (error.code === 'NetworkingError' || 
        error.code === 'TimeoutError' || 
        error.name === 'ThrottlingException' ||
        error.statusCode === 429 ||
        error.statusCode === 500) {
      return true;
    }
    return false;
  }
};

/**
 * Utility function to create a properly namespaced cloudwatch metric name
 * @param {string} serviceName - The service name 
 * @param {string} metricName - The metric name
 * @returns {string} Formatted metric name
 */
export const createMetricName = (serviceName, metricName) => {
  return `${serviceName}_${metricName}`;
};

/**
 * Helper to generate standardized tags for AWS resources
 * @param {string} project - Project name
 * @param {string} service - Service name
 * @param {string} stage - Deployment stage
 * @param {Object} additionalTags - Any additional tags
 * @returns {Object} Tags object
 */
export const generateResourceTags = (project, service, stage, additionalTags = {}) => {
  return {
    Project: project,
    Service: service,
    Stage: stage,
    ...additionalTags
  };
};
