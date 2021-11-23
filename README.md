# AWS Load balancer with Lambda as the target (Deploy with Terraform)

AWS API Gateway is a great tool to use with Lambda. However, sometimes API Gateway can be quite expensive.
If you are using API Gateway just as a proxy to lambda, and you have quite a large number of requests comes in,
you can use AWS Load balancer with Lambda as the target.

In this repository, using Terraform, you can deploy a sample application with ALB and Lambda as the target.

### Components to be created with Terraform

1. New VPC
2. Two Subnets
3. Internet Gateway
4. Route Table with IGW attached (Here default route table is used)
5. Application Load Balancer
6. Security Group for ALB
7. Placement Group
8. Lambda function
9. Add Lambda as a target in placement group.

### How to Use

1. Clone the repository.

2. Change permission of deploy.sh

```
chmod 775 deploy.sh
```
3. Run 
```
./deploy.sh
```

4. This will download necessary packages and create above resources upon your confirmation.

5. You may access the system using the output value `lb_address`

### To delete the stack

By default ALB's termination policy is set to `true` which will prevent delete it. So, first needs to set it as false.

In the terraform.tfvars file set the `ALB_DELETION_PROTECTION` value to `false`

To apply the change, run
```
terraform plan -out tfout.plan
terraform apply tfout.plan
```

And to destroy the stack, run
```
terraform destroy
```


