
##########################################################
# Create as much Cloud9 enviroments as users
##########################################################
module "cloud9-ide" {
  depends_on = [aws_route_table_association.vpc-cloud9_ra-subnet]
  count      = length(data.aws_iam_users.users.arns)
  source     = "./modules/cloud9-ide"

  tags      = var.tags
  region    = var.region["region"]            // region to deploy Cloud9 enviroments
  subnet_id = aws_subnet.vpc-cloud9_subnet.id // subnet where allocate Cloud9 instances ni
  user_name = tolist(data.aws_iam_users.users.names)[count.index]
  user_arn  = tolist(data.aws_iam_users.users.arns)[count.index]
}

// Achieve all the users allocated in path prefix
data "aws_iam_users" "users" {
  path_prefix = var.users_path-prefix
}

##########################################################
# Create new VPC and subnet for Cloud9 instance machines
##########################################################
// Cloud9 VPC
resource "aws_vpc" "vpc-cloud9" {
  cidr_block           = var.vpc-cloud9_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

// IGW need for Internet access
resource "aws_internet_gateway" "vpc-cloud9_igw" {
  vpc_id = aws_vpc.vpc-cloud9.id
  tags   = var.tags
}

// Subnet for Cloud9 instances
resource "aws_subnet" "vpc-cloud9_subnet" {
  vpc_id            = aws_vpc.vpc-cloud9.id
  cidr_block        = cidrsubnet(var.vpc-cloud9_cidr, 1, 0)
  availability_zone = var.region["region_az1"]
  tags              = var.tags
}

// Create route to INET
resource "aws_route_table" "vpc-cloud9_rt-public" {
  vpc_id = aws_vpc.vpc-cloud9.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-cloud9_igw.id
  }
  tags = var.tags
}

// Route table association subnet
resource "aws_route_table_association" "vpc-cloud9_ra-subnet" {
  subnet_id      = aws_subnet.vpc-cloud9_subnet.id
  route_table_id = aws_route_table.vpc-cloud9_rt-public.id
}

