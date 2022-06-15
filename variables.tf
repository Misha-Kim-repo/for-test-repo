variable "region" {
  description = "default region-designate"
  type        = string
  #default    = "ap-northeast-2" 
}

variable "current_region" {
    description = "Your AWS current region-designate"
    type        = string 
}

variable "account_id" {
  description = "Allowed AWS account ID-designate"
  type        = string
}

variable "current_id" {
  description = "Your current account id-designate"
  type        = string 
}

variable "prefix" {
  description = "prefix for aws resources and tags-designate"
  type        = string 
}

variable "name" {
  description = "security group's name-designate"
  type        = string
  default     = ""   
}

variable "vpc_id" {
  description = "vpc id-designate"
  type       = string
}

variable "tags" {
  description = "tags map-designate"
  type        = map(string) 
}

variable "rules" {
  description = "security group's rules-designate"
  type       = map(any) 
}
