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

echo "############### to the job here ###############"

#!/bin/bash
set -eu
set -o pipefail

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text 2>&1)
echo $(pwd)
docker --version
REPOSITORY_URI="478435181338.dkr.ecr.eu-west-3.amazonaws.com/ecr_devops_bald_bis"
IMAGE_TAG="1.0.0"
docker build -t $REPOSITORY_URI:latest .
docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG
docker push $REPOSITORY_URI:$IMAGE_TAG