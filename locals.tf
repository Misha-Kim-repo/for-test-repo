locals {
    sg_rules = flatten([
        for key, value in var.rules : {
            name                =   key
            type                =   value.type
            from_port           =   value.from_port
            to_port             =   value.to_port
            protocol            =   value.protocol
            cidr_blocks         =   value.cidr_blocks
            ipv6_cidr_blocks    =   value.ipv6_cidr_blocks
            prefix_list_ids     =   value.prefix_list_ids
            description         =   value.description 
        }
    ])
}