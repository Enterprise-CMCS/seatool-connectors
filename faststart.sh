
aws ecs update-service --no-cli-pager --cluster seatool-ksqlom-$1-connect --service ksqldb-headless --desired-count 1