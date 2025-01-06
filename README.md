# Terraform

### Setup
- Ensure you have Terraform installed on your machine. If not, you can download it [here](https://www.terraform.io/downloads.html).
- Ensure you have the aws CLI installed on your machine. If not, you can download it [here](https://aws.amazon.com/cli/).

#terraform #obelion 

----

1. destroy your manually created autoscaling group and all of its associated resources (only keep the custom image of wordpress)

2. create a terraform script to do the following
	1. create a vpc with 2 subnets (private and public)
	2. create a launch template that contains your image of wordpress
	3. create an autoscaling group that has 2 machines of type t3.small and a simple scaling policy that adds more machines if cpu reaches 50%
	4. database instance with mysql 8 installed on it
	5. add your terraform script to a private github repo
	6. use s3 as backend for your terraform state
	7. try to separating the functions of your terraform into abstract modules 

**Extra**

- create 2 ec2 machines using terraform and run the ansible playbook that installs mysql + wordpress on both of them at the same time

**Resources**

https://www.cherryservers.com/blog/terraform-and-ansible#how-to-use-ansible-with-terraform-terraform-and-ansible-example-use-case

https://registry.terraform.io/providers/ansible/ansible/latest/docs/resources/playbook


#### Implementation Steps
1. [x] Setup Terraform structure
2. [x] setup state in S3
3. [x] Finish database module -> ec2 instance with mysql8 in the private subnet
4. [x] Finish vpc module -> create vpc with 2 subnets (private and public)
5. [x] Finish launch template module -> from my wordpress image
6. [x] Finish Autoscaling group module -> 2 machines of type `t3.small`
	1. [x] with simple scaling to add more if cpu reaches 50%
	2. [x] configure load balancer
7. [ ] Finish Extra Task


### Questions
- should create subnets dynamically or statically?
- Handle changes in script or user data without destorying and recreating infra?
