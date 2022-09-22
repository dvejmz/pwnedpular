#!/usr/bin/env bash

set -e

if [[ ! -d dist/ ]]; then
    echo "Build directory not found"
    exit 1
fi

echo "Deploying app to S3..."
set -x
aws s3 sync --delete './dist/' 's3://pwnedpular.apps.sgfault.com/'
set -x
echo "Done"

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths '/*'
echo "Done"
