account_id = "414054023605"
region = "ap-northeast-2"
prefix = "Misha.K"
name = "for-TEST"
vpc_id = "vpc-fd9b4396"
#object({
#    type                      = string
#    from_port                 = string
#    to_port                   = string
#    protocol                  = string
#    cidr_blocks               = list(string)
#    ipv6_cidr_blocks          = list(string)
#    source_security_group_id  = string
#    prefix_list_ids           = list(string)
#    description               = string
#    self                      = bool
#  })
tags = {
    "CreatedByTerraform" = "true",
    "TerraformModuleName" = "terraform-aws-module-security-groups",
    "TerraformModuleVersion" = "v1.0.4"
}

rules = {
        "test" = {
            security_group_id = "sg-9f84f0fd"
            type    = "ingress"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["211.60.50.130/32"]
            source_security_group_id = ""
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            self = false
            description = "for test SG rules"

        }
    }


