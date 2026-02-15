variable "db_password" {
  description = "RDS root password"
  type        = string
  sensitive   = true  #log password
}