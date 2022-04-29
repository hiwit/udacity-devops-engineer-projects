source helpers.sh


export AWS_PAGER=""
account="--region=us-east-1 --profile udacity_1"
capabilities="--capabilities CAPABILITY_NAMED_IAM"

if [ -z "$1" ]
then
    echo "no cloudformation file to execute"
    exit 1
fi

env=`cat properties.json | jq '.[] | select(.ParameterKey=="Env") | .ParameterValue' -r`
file=$1
filename=`echo $1 | sed 's/\.[^.]*$//'`
stack="${env}-${filename}"



# validate "network.yml"
validate $file

if ! aws cloudformation describe-stacks --stack-name ${stack} ${account} > /dev/null; then
    echo "creating ${file}"
    aws cloudformation create-stack --stack-name ${stack} --template-body file://${file} --parameters file://properties.json  ${capabilities} ${account}
else
    echo "updating ${file}"
    aws cloudformation update-stack --stack-name ${stack} --template-body file://${file} --parameters file://properties.json  ${capabilities} ${account}
fi
