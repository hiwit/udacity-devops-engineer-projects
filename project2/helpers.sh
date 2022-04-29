validate() {
    cfn-lint $1
    # aws cloudformation validate-template --template-body file://$1 --region=us-east-1 --profile udacity_1
}