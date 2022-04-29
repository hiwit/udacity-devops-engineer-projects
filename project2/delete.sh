stack=p2

export AWS_PAGER=""
account="--region=us-east-1 --profile udacity_1"

aws cloudformation delete-stack --stack-name $stack ${account}