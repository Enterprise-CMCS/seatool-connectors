output=$(aws ecr describe-repositories --repository-names confluentinc/ksqldb-server 2>&1)
acct=$(aws sts get-caller-identity --query "Account" --output text)
  if echo ${output} | grep -q RepositoryNotFoundException; then
    echo does not exist
    docker pull confluentinc/ksqldb-server:0.26.0
    aws ecr create-repository --region us-east-1 --repository-name confluentinc/ksqldb-server:0.26.0
    docker tag confluentinc/ksqldb-server:0.26.0 ${acct}.dkr.ecr.us-east-1.amazonaws.com/confluentinc/ksqldb-server:0.26.0
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${acct}.dkr.ecr.us-east-1.amazonaws.com
    docker push ${acct}.dkr.ecr.us-east-1.amazonaws.com/confluentinc/ksqldb-server:0.26.0
  else
    echo already exists
  fi