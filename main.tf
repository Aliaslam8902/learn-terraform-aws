# Data sources for latest AMIs (region-specific)
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "windows_server_2022" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

# Network module
module "network" {
  source = "./modules/network"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  project_name        = var.project_name
}

# Windows Bastion module
module "bastion" {
  source = "./modules/bastion"

  ami           = data.aws_ami.windows_server_2022.id
  instance_type = var.instance_type
  subnet_id     = module.network.public_subnet_id
  key_name      = var.windows_key_name
  vpc_id        = module.network.vpc_id
  project_name  = var.project_name
  allowed_rdp_cidr = var.allowed_rdp_cidr
}

# Linux LAMP server module
module "linux_vm" {
  source = "./modules/linux_vm"

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id     = module.network.private_subnet_id
  key_name      = var.linux_key_name
  vpc_id        = module.network.vpc_id
  bastion_sg_id = module.bastion.security_group_id
  project_name  = var.project_name
}