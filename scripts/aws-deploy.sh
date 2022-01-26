#!/bin/bash
set -e

echo CODEBUILD_RESOLVED_SOURCE_VERSION: ${CODEBUILD_RESOLVED_SOURCE_VERSION} #BuildSHA1
echo CODEBUILD_SOURCE_VERSION: ${CODEBUILD_SOURCE_VERSION}
echo CODEBUILD_BUILD_ARN: ${CODEBUILD_BUILD_ARN}
echo AWS_REGION: ${AWS_REGION}
echo CODEBUILD_BUILD_NUMBER: ${CODEBUILD_BUILD_NUMBER}
echo CODEBUILD_SOURCE_REPO_URL: ${CODEBUILD_SOURCE_REPO_URL}

echo BranchName:            ${BranchName}
echo ArtifactsS3Bucket:     ${ArtifactsS3Bucket}




# set -f                     # avoid globbing (expansion of *).
array=(${CODEBUILD_BUILD_ARN//:/ })
AccountId=${array[4]}
echo AccountId: ${AccountId}
# unset +f

echo TargetRegion: ${AWS_REGION}
BuildSHA1=${CODEBUILD_RESOLVED_SOURCE_VERSION}
echo BuildSHA1: ${BuildSHA1}

# Deploy the stack autoupdate
FullStackName='autoupdatestack'
aws cloudformation deploy \
    --no-fail-on-empty-changeset \
    --template-file ./autoupdatestack.yml \
    --stack-name $FullStackName \
    --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        BranchName=$BranchName \




# # # # pip install aws-sam-cli
# # # # USER_BASE_PATH=$(python -m site --user-base)
# # # # export PATH=$PATH:$USER_BASE_PATH/bin
# # # # sam build -t ./test.yml
# # # # sam package  \
# # # #   --template-file         ./test.yml \
# # # #   --output-template-file  ./test.yml \
# # # #   --s3-bucket ${ArtifactsS3Bucket} \
# # # #   --s3-prefix ${BranchName}/${BuildSHA1} \
    
