output "account_id" {
    value = module.security_groups.account_id
}

output "current_region" {
    value = module.security_groups.region
}

output "vpc_id" {
    value = local.vpc_id.id
}
output "sg_rules" {
    value = local.security_groups
}