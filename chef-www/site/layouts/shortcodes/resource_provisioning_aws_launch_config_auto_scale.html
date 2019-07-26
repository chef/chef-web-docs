The following example uses the `aws_launch_configuration` resource to
create an image and instance type, and then the `aws_auto_scaling_group`
resource to build out a group of machines:

``` ruby
require 'chef/provisioning/aws_driver'

with_driver 'aws::eu-west-1' do
  aws_launch_configuration 'launch-config-name' do
    image 'ami-f0b11187'
    instance_type 't1.micro'
  end

  aws_auto_scaling_group 'auto-scaling-group-name' do
    desired_capacity 3
    min_size 1
    max_size 5
    launch_configuration 'launch-config-name'
  end
end
```