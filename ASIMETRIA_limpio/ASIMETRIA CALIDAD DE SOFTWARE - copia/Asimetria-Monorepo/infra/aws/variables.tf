variable "aws_region" {
  description = "AWS region where the application server will be created."
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name used in AWS resource tags."
  type        = string
  default     = "asimetria"
}

variable "instance_type" {
  description = "EC2 instance type. t3.medium matches the application's documented 2 vCPU / 4 GiB minimum."
  type        = string
  default     = "t3.medium"
}

variable "admin_cidr" {
  description = "Your public IPv4 CIDR allowed to connect over SSH, for example 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrhost(var.admin_cidr, 0)) && var.admin_cidr != "0.0.0.0/0"
    error_message = "Set a valid IPv4 CIDR for your address; SSH must not be open to the entire internet."
  }
}

variable "ssh_public_key" {
  description = "Contents of the SSH public key to install on the EC2 instance. Never use a private key here."
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^(ssh-ed25519|ssh-rsa|ecdsa-sha2-nistp(256|384|521)) ", trimspace(var.ssh_public_key)))
    error_message = "Provide the contents of an OpenSSH public key."
  }
}

variable "domain_name" {
  description = "DuckDNS hostname configured outside AWS; Terraform does not manage DuckDNS."
  type        = string
  default     = "asimetria.duckdns.org"
}
