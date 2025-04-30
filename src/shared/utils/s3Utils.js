/**
 * Shared S3 utilities for consistent S3 operations across services
 */

import fs from "fs";
import archiver from "archiver";
import { S3Client, PutObjectCommand, GetObjectCommand } from "@aws-sdk/client-s3";
import { logEvent, logError } from "./errorHandling.js";

/**
 * Creates a zip file from the provided content
 * @param {string} targetFilePath - Local path where to create the zip file
 * @param {string} content - Content to include in the zip file
 * @param {string} entryName - Name of the file within the zip archive (default: 'combined.sql')
 * @returns {Promise<void>} - Resolves when zip creation is complete
 */
export const createZipFile = async (targetFilePath, content, entryName = "combined.sql") => {
  return new Promise((resolve, reject) => {
    const output = fs.createWriteStream(targetFilePath);
    const archive = archiver("zip", { zlib: { level: 9 } });

    output.on("close", function () {
      logEvent("info", `Zip archive created`, {
        size: archive.pointer(),
        path: targetFilePath
      });
      resolve();
    });

    output.on("error", function (err) {
      logError(err, "createZipFile:output", { targetFilePath });
      reject(err);
    });

    archive.on("error", function (err) {
      logError(err, "createZipFile:archive", { targetFilePath });
      reject(err);
    });

    archive.pipe(output);
    archive.append(content, { name: entryName });
    archive.finalize();
  });
};

/**
 * Uploads a file to S3
 * @param {string} bucketName - The S3 bucket name
 * @param {string} key - The S3 object key
 * @param {Buffer|string} body - The file content to upload
 * @param {object} options - Additional options for the S3 PUT operation
 * @returns {Promise<object>} - The S3 PutObjectCommand response
 */
export const uploadToS3 = async (bucketName, key, body, options = {}) => {
  const s3 = new S3Client({});
  
  try {
    logEvent("info", `Uploading to S3`, {
      bucket: bucketName,
      key: key,
      bodySize: typeof body === 'string' ? body.length : body.byteLength
    });
    
    const command = new PutObjectCommand({
      Bucket: bucketName,
      Key: key,
      Body: body,
      ...options
    });
    
    const response = await s3.send(command);
    
    logEvent("info", `Successfully uploaded to S3`, {
      bucket: bucketName,
      key: key,
      eTag: response.ETag
    });
    
    return response;
  } catch (err) {
    logError(err, "uploadToS3", {
      bucket: bucketName,
      key: key
    });
    throw err;
  }
};

/**
 * Helper function to create a zip and upload to S3 in one operation
 * @param {string} bucketName - The S3 bucket name
 * @param {string} key - The S3 object key
 * @param {string} content - Content to include in the zip
 * @param {string} tempFilePath - Local path for temporary zip file
 * @returns {Promise<object>} - The S3 upload response
 */
export const zipAndUploadToS3 = async (bucketName, key, content, tempFilePath) => {
  await createZipFile(tempFilePath, content);
  const fileBuffer = fs.readFileSync(tempFilePath);
  return await uploadToS3(bucketName, key, fileBuffer);
};

/**
 * Downloads a file from S3
 * @param {string} bucketName - The S3 bucket name
 * @param {string} key - The S3 object key
 * @returns {Promise<Object>} - Object containing the file Body and metadata
 */
export const downloadFromS3 = async (bucketName, key) => {
  const s3 = new S3Client({});
  
  try {
    logEvent("info", `Downloading from S3`, {
      bucket: bucketName,
      key: key
    });
    
    const command = new GetObjectCommand({
      Bucket: bucketName,
      Key: key,
    });
    
    const response = await s3.send(command);
    
    logEvent("info", `Successfully downloaded from S3`, {
      bucket: bucketName,
      key: key,
      contentType: response.ContentType,
      contentLength: response.ContentLength
    });
    
    return response;
  } catch (err) {
    logError(err, "downloadFromS3", {
      bucket: bucketName,
      key: key
    });
    throw err;
  }
};
