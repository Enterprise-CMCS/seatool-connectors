# Shared Utilities for seatool-connectors

This directory contains shared utilities and modules designed to be used across multiple services in the seatool-connectors project.

## Directory Structure

```
src/shared/
├── package.json         # Dependencies for shared modules
├── utils/               # Shared utility functions
│   ├── index.js         # Main export point for all utilities
│   ├── errorHandling.js # Error handling and logging utilities
│   └── s3Utils.js       # S3 operations utilities
```

## Available Utilities

### Error Handling and Logging (`errorHandling.js`)

Contains utilities for consistent error handling, retries, and structured logging.

#### Key Functions:

- `executeWithRetry(operation, options)`: Executes an async operation with configurable retry logic
- `logEvent(level, message, data)`: Structured logging with consistent format
- `logError(error, context, additionalInfo)`: Safely logs errors with context
- `sanitizeForLogging(obj, sensitiveKeys)`: Sanitizes objects for logging

### S3 Utilities (`s3Utils.js`)

Provides consistent S3 operations across services.

#### Key Functions:

- `createZipFile(targetFilePath, content, entryName)`: Creates a zip file from content
- `uploadToS3(bucketName, key, body, options)`: Uploads content to S3
- `zipAndUploadToS3(bucketName, key, content, tempFilePath)`: Combines zip creation and upload
- `downloadFromS3(bucketName, key)`: Downloads a file from S3

## Usage

Import utilities from the main index:

```javascript
import { 
  executeWithRetry,
  logEvent,
  logError,
  uploadToS3,
  DEFAULT_RETRY_CONFIG
} from "../../../shared/utils/index.js";

// Example: Execute with retry logic
await executeWithRetry(
  async () => {
    // async operation here
    await someAsyncOperation();
  },
  {
    ...DEFAULT_RETRY_CONFIG,
    onRetry: (error, retryCount) => {
      logEvent("warn", `Retrying operation`, { retryCount });
    }
  }
);

// Example: Structured logging
logEvent("info", "Operation completed", { 
  duration: 123,
  itemCount: 5
});
```

## Adding New Utilities

When adding new utilities:

1. Create a new file in the `utils/` directory
2. Export utilities from the file
3. Add exports to `index.js`
4. Update this README with documentation
5. Consider adding tests for the utilities

## Best Practices

- Use these shared utilities instead of duplicating functionality
- Follow the established patterns for error handling and logging
- Keep utilities focused and modular
- Document all exported functions with JSDoc comments
