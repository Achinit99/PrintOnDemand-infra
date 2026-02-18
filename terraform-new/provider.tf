terraform {
  required_providers {
    # AWS Provider configuration
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Adding GitHub Provider to manage repository secrets
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1" # Mumbai region
}

# Configure the GitHub Provider with your Personal Access Token
provider "github" {
  token = var.github_token
}
