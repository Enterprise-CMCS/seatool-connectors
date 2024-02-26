bucketinfo=$(sls ksqlom info --stage "$1" --verbose | grep 'KsqlDdlBucket')
bucket="${bucketinfo#*KsqlDdlBucket: }"
keyinfo=$(sls ksqlom info --stage "$1" --verbose | grep 'KsqlDdlKey')
key="${keyinfo#*KsqlDdlKey: }"

echo $bucket
echo $key

CI=true sls ksqlom package --stage $1
aws s3 cp src/services/ksqlom/.serverless/ddl.zip s3://${bucket}/${key}