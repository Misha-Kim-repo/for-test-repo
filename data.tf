data "aws_vpc" "current_vpc" {
    #본인 테스트 계정의 defalt VPC
    id = "vpc-fd9b4396"
}

data "aws_security_group" "selected_SG" {
    #본인 테스트 계정의 defalt VPC
    id = "sg-9f84f0fd"
}
