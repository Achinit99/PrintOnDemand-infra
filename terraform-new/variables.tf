variable "db_password" {
  description = "RDS root password"
  type        = string
  sensitive   = true 
}

# Add this for your GitHub Token
variable "github_token" {
  description = "GitHub Personal Access Token for Terraform"
  type        = string
  sensitive   = true # This prevents the token from being printed in the logs
}

# Add this for your Repo Name (Optional but good practice)
variable "github_repo" {
  description = "The name of the backend GitHub repository"
  type        = string
  default     = "PrintOnDemand-backend"
}