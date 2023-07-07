# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
    access_key = "ASIA52OUDJN2FEP3NGWL"
    secret_key = "bYPF2/ORW2EaGLQ2fvqrtqmOzRA2vaO90cvHLNqL"
    token = "FwoGZXIvYXdzEPn//////////wEaDAzIZjRQfM0ODsib9SLVAeldKgyyTWeo0ENjoaGWbabUhH4sDiB6SJvHG2VQuF+Id1MgpyfKhLDvzIpvv2lcnYeF5cQaNsISuIwthQbNPpPnkhQHwm6+VhrtJH7eXNFqFDfNXnDfXOCQ66ugL0iqaqAOA8vVkdR0xbNkpOSnAb2ul4EGZA7XJBgZraa6zQj7PMRtzDatQDUVAJqMPa7+O6BV1vqPEkBFrHZSmMBJCGx8ha4xlcTMwGd1ade5vzJzxj1mYblJJT1kwlBY8u71bnHGtZBR4ByJcy4d3RL3+ksDYjKvyCj666ClBjItoe5x/pqMfTcUz4o3e/hziK2cn/n9XiAKC691SfWdkE850qFQaYzRYpGfzBnq"
    region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "UdacityT2" {
    count = "4"
    subnet_id = "subnet-0e7489bcfcb6c9fef"
    ami = "ami-06ca3ca175f37dd66"
    instance_type = "t2.micro"
    tags = {
        Name = "UdacityT2"
    }
}
# module "ec2_instance" {
#     source = "terraform-aws-modules/ec2-instance/aws"

# }

# TODO: provision 2 m4.large EC2 instances named Udacity M4

# resource "aws_instance" "UdacityM4" {
#     count = "2"
#     subnet_id = "subnet-0e7489bcfcb6c9fef"
#     ami = "ami-06ca3ca175f37dd66"
#     instance_type = "m4.large"
#     tags = {
#         Name = "UdacityM4"
#     }
# }