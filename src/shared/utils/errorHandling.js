/**
 * Error handling and retry utilities for AWS Lambda functions
 */

/**
 * Executes an operation with retry logic
 * @param {Function} operation - The async operation to perform
 * @param {Object} options - Options for retry behavior
 * @param {number} options.maxRetries - Maximum number of retries (default: 10)
 * @param {number} options.retryDelay - Delay between retries in ms (default: 10000)
 * @param {Function} options.retryCondition - Optional function to determine if retry should happen (default: retry on any error)
 * @param {Function} options.onRetry - Optional callback function executed before each retry
 * @returns {Promise<any>} - Result of the operation
 */
export const executeWithRetry = async (operation, options = {}) => {
  const {
    maxRetries = 10,
    retryDelay = 10000,
    retryCondition = () => true,
    onRetry = () => {},
  } = options;

  let retries = 0;
  let success = false;
  let result;
  let lastError;

  while (!success && retries < maxRetries) {
    try {
      result = await operation();
      success = true;
    } catch (error) {
      lastError = error;
      
      if (!retryCondition(error)) {
        console.error(`Operation failed with non-retryable error: ${JSON.stringify(error)}`);
        throw error;
      }

      retries++;
      console.error(`Error in operation: ${JSON.stringify(error)}`);
      console.log(`Retrying in ${retryDelay / 1000} seconds (Retry ${retries}/${maxRetries})`);
      
      await onRetry(error, retries);
      await new Promise((resolve) => setTimeout(resolve, retryDelay));
    }
  }

  if (!success) {
    console.error(`Failed after ${maxRetries} retries.`);
    throw lastError;
  }

  return result;
};

/**
 * Structured logging with consistent format
 * @param {string} level - Log level (info, warn, error)
 * @param {string} message - Log message
 * @param {Object} data - Additional data to log
 */
export const logEvent = (level, message, data = {}) => {
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    level,
    message,
    ...data
  }));
};

/**
 * Sanitizes an object for logging, handling circular references
 * and removing sensitive data
 * @param {Object} obj - Object to sanitize
 * @param {Array<string>} sensitiveKeys - Keys of sensitive data to mask
 * @returns {Object} - Sanitized object
 */
export const sanitizeForLogging = (obj, sensitiveKeys = ['password', 'token', 'secret', 'key']) => {
  const seen = new WeakSet();
  
  return JSON.parse(JSON.stringify(obj, (key, value) => {
    // Handle circular references
    if (typeof value === 'object' && value !== null) {
      if (seen.has(value)) {
        return '[Circular]';
      }
      seen.add(value);
    }
    
    // Mask sensitive data
    if (typeof key === 'string' && sensitiveKeys.some(k => key.toLowerCase().includes(k))) {
      return '[REDACTED]';
    }
    
    return value;
  }));
};

/**
 * Safely logs an error with all available details
 * @param {Error} error - Error object
 * @param {string} context - Context where error occurred
 * @param {Object} additionalInfo - Any additional information to log
 */
export const logError = (error, context, additionalInfo = {}) => {
  const errorDetails = {
    message: error.message,
    stack: error.stack,
    ...additionalInfo,
    context
  };

  logEvent('error', `Error in ${context}: ${error.message}`, sanitizeForLogging(errorDetails));
};
