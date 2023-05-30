
output "urn" {
  value       = module.vpc.*.urn
  description = "Name of SSH key."
}
output "id" {
  value       = module.vpc.*.id
  description = "The unique identifier for the VPC.."
}