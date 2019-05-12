require 'dotenv/load'
# require 'aws-sdk'
require 'aws-sdk-cloudformation'

p('...Uplink pair service started!')

cloudformation = Aws::CloudFormation::Client.new(
  # region: region_name,
  # credentials: credentials,
  # ...
)

#list_stack_sets(params = {}) ⇒ Types::ListStackSetsOutput
#list_stack_resources(options = {}) ⇒ Types::DescribeStackResourcesOutput
#describe_stacks  <<<--- THIS should be the primary source, with describe permit
#describe_stack_instance
#describe_stack_resources(options = {}) ⇒ Types::DescribeStackResourcesOutput

# resp = cloudformation.list_stack_sets({
#   # next_token: "NextToken",
#   # max_results: 100,
#   status: "ACTIVE", # accepts ACTIVE, DELETED
# })

# get stacks info
resp = cloudformation.describe_stacks({
  # next_token: "NextToken",
  # max_results: 100,
  # status: "ACTIVE", # accepts ACTIVE, DELETED
})

# get stack resources
# cloudformation.describe_stack_resources({
#   stack_name: <stack_name_here> 
# })
# ==> response
# 
# logical_resource_id === 'UplinkInstanceGroup'
# status === 'CREATE_COMPLETE'
# physical_resource_id => our ec2 key

# ===> EC2 with physical_resource_id

#EC2 Client
#describe_instances(options = {}) ⇒ Types::DescribeInstancesResult
# resp:
# resp.reservations[0].instances[0].public_ip_address #=> String

# describe autoscaling groups
# https://docs.aws.amazon.com/en_us/autoscaling/ec2/APIReference/API_DescribeAutoScalingGroups.html

# describe instances by IDs
# resp = client.describe_instances({
#   instance_ids: [
#     "i-1234567890abcdef0", 
#   ], 
# })

# This example describes the instances with the Purpose=test tag.
# resp = client.describe_instances({
#   filters: [
#     {
#       name: "tag:Purpose", 
#       values: [
#         "test", 
#       ], 
#     }, 
#   ], 
# })

p resp
# Resp struct
# resp.summaries #=> Array
# resp.summaries[0].stack_set_name #=> String
# resp.summaries[0].stack_set_id #=> String
# resp.summaries[0].description #=> String
# resp.summaries[0].status #=> String, one of "ACTIVE", "DELETED"
# resp.next_token #=> String