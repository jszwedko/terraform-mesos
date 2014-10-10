terraform-mesos
=========
A repo to test 1 mesos master and 1 mesos slave on AWS.

# Prereqs
## Basic stuff
- AWS access and secret keys
- [Terraform](http://terraform.io)
- ZoneID for Route53

## Things you need to do
- Copy ```terraform.tfvars.example``` to ```terraform.tfvars``` and replace the values (or supply ```-var``` in your command line) 
- Check ```variables.tf``` to ensure you are using the proper AMIs. Right now I have it set to Ubuntu Trusty (14.04) with an instance backed store.
- mesos-master.tf has Availability Zones set to us-west-2a, b and c. Please change to meet your needs.

## Fire it up
The default will launch an m3.medium since this is the smallest instace that uses an instance back store. 
```
cd aws
terraform apply
```

# Helpful commands
- Show info about the instances
```terraform show terraform.tfstate```
- Test your terraform config
```terraform plan```
- Delete everything
```
terraform plan -destroy -out=terraform.tfplan
terraform apply terraform.tfplan
```

# Next steps
- Setup ASG, lauch configuration and user-data for mesos-slave
- Add the AZs as a variable