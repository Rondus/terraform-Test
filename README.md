# Terraform and Ansible
I have used terraform for provisioning the intrstructure which include; VPC, Internet Gateway, RT, Servers 

# Add user itoro
``` sh
# Create a REDHAT EC2 instance in aws cloud and assigned IAM roles
AmazonEC2FullACCESS
AmazonVPCFullACCESS
$ sudo useradd itoro
$ echo "itoro  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/itoro
$ sudo su - itoro
# Enable PassowrdLogin and assign password to itoro user

```
## Infrastructure As A Code - 
### Terraform Installation

``` sh
$ sudo su itoro
 sudo yum install wget git unzip -y
 wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
 sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
 #Export terraform binary path temporally
 export PATH=$PATH:/usr/local/bin
#Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
 source ~/.bashrc   
```
#### Clone terraform scripts
``` sh
 git clone https://github.com/Rondus/terraform-Test.git
 cd terraform-Test
```
###### <span style="color:orange"> Update Key Name in variables.tf file before executing terraform script </span>

## Infrastructure As A Code - Terraform
##### Create the intrstructure (VPC, Subnets, Route Tables, IGW, EC2 Instances, etc)
``` sh
# Initialise to install plugins
$ terraform init terafrom_scripts/
# Validate teffaform scripts
$ terraform validate terafrom_scripts/
# Plan terraform scripts which will list resouce which will be created
$ terraform plan terafrom_scripts/
# Apply to create resources
$ terraform apply --auto-approve terafrom_scripts/
```

###### <span style="color:red">Replace \<Pemfile> with your pemfile path in server </span>
```sh

##  Destroy Infrastructure  
```sh
$ terraform destroy --auto-approve terafrom_scripts/
```
