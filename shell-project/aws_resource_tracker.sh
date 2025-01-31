#!/bin/bash

#################
# Author:chets
# Date:14th -jan
#
# Version: v1
#
# ths script will report the AWS resource usage
#######################

set -x

# AWS s3 bucket listing
aws s3 ls

#list ec2 instances
echo "Print list of ec2 buckets"
aws ec2 describe-instances

#list aws lambda

