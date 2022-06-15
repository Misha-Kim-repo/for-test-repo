module "security_groups" {
    source = "../bsg-project/module"
    
    region = var.region
    current_region = var.current_region
    account_id = var.account_id
    current_id = var.current_id
    
    prefix = var.prefix
    name   = var.name
    vpc_id = var.vpc_id
    tags   = var.tags 

    rules  = var.rules 
}