output "vpc_id" {
  value       = module.vpc.id
  description = "The unique identifier for the VPC."
}

output "vpc_urn" {
  value       = module.vpc.urn
  description = "The uniform resource name (URN) for the VPC."
}

output "vpc_default" {
  value       = module.vpc.default
  description = "Whether the VPC is the default one for the region."
}

output "vpc_created_at" {
  value       = module.vpc.created_at
  description = "The date and time when the VPC was created."
}
