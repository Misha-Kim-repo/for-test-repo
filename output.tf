output "current_id" {
    value = module.security_groups.current_id
}

output "current_region" {
    value = module.security_groups.current_region
}

output "vpc_id" {
    value = data.aws_vpc.current_vpc
}

output "sg" {
    value = module.security_groups.aws_security_group
}

output "sg_rules" {
    value = local.sg_rules
}
