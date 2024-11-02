
### Terraform Cheat Sheet

```markdown
# Terraform Cheat Sheet

## 1. Basics

### Providers
- **Definition**: Define the cloud provider.
  
Example:
```hcl
provider "aws" {
  region = "us-west-2"
}

Resources

    Definition: Define resources to be managed.

Example:

hcl

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

2. Variables
Defining Variables

    Syntax: Define variables in a variables.tf file.

Example:

hcl

variable "instance_type" {
  description = "Type of instance"
  default     = "t2.micro"
}

Using Variables

hcl

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}

3. Outputs
Defining Outputs

    Purpose: Return information after applying configurations.

Example:

hcl

output "instance_id" {
  value = aws_instance.example.id
}

4. State Management
Commands

    View state: terraform state list
    Show state details: terraform show
    Import existing resources: terraform import <resource> <id>

5. Modules
Using Modules

    Purpose: Organize configuration into reusable units.

Example:

hcl

module "vpc" {
  source = "./vpc"
  cidr   = "10.0.0.0/16"
}

6. Best Practices

    Use Version Control: Keep Terraform files in a VCS.
    Use Terraform Workspaces: Separate environments.