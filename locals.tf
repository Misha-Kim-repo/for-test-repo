locals {
    vpc_id = data.aws_vpc.current_vpc
}

locals {
    security_groups = data.aws_security_group.selected_SG
}