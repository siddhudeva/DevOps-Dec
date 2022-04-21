resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
     region     = "us-east-1"
     tags {
         name   =  main_vpc
         ENV    =  var..env
     }
}

resource "aws_subnet" "subnet_main" {
    aws_vpc = aws_vpc.main.id

}

resource "aws_subnet" "public_subnet" {
    count            = length(var.PUBLIC_SUBNET_CIDR)
    aws_vpc          = aws_vpc.main.id
    cidr_block       = var.PUBLIC_SUBNET.index[count.index]
    availibilty_zone = var.AZs
    tags             = {
        name         = public_subnet
        ENV          = var.env
    }
}

resource "aws_subnet" "private_subnet" {
    count            = length(var.PRIVATE_SUBNET_CIDR)
    cidr_block       = var.PRIVATE_SUBNET_CIDR[count.index]
    aws_vpc          = aws_vpc.main.id
    availibilty_zone = var.AZs
    tags {
        name         = private_subnet
        ENV          = var.env
    }

}


###### vars.tf
variable "PUBLIC_SUBNET_CIDR" {}
variable "PRIVATE_SUBNET_CIDR" {}
variable "env" {}
varible "AZs"

#### env/dev.tfvars
PUBLIC_SUBNET_CIDR  = ["10.0.1.0/24" , ""10.0.2.0/24"]
PRIVATE_SUBNET_CIDR = ["10.0.12.0/24" , "10.0.10.0/24"]
env                 = dev
AZs                 = ["us-east-1a" , "us-east-1b"]

##### dev-backend.tfvars
bucket          = "s3-bucket1"
key             = "vpc/dev/terraform.tfstate"
region          = "us-east-1"

###


#### data.tf 
# data.tf we use it for getting already existing resources attribute values
output "aws_caller_identity" "current" {}

output "aws_vpc" "default" {
    default     = true
}

###output.tf
# output file is used to bring the atribute values of the resources that are created using these terraform files

output "aws_vpc_id" {
    value = aws_vpc.main.id
}
output "aws_subnet_public" {
    value = aws_subnet.public_subnet.id
}
output "aws_default_vpcid" {
    data.aws_vpc.default.id
}
output "aws_default_cidr" {
    data.aws_vpc.default.cidr_block
}
#### COMMANDS:
# terrafrom init -backend-config=env/dev-backend.tfvars
#  terraform apply -auto-approve -var-file=env/dev.tfvars