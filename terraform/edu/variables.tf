variable "profile" {}
variable "region" {}
variable "env" {}
variable "system" {}
variable "aws" {
  type = object({
    subnet = object({
      public = object({
        az1 = object({
          id = string
        })
        az4 = object({
          id = string
        })
      })
    })
    security_group = object({
      ids = list(string)
    })
    key_pair = object({
      name = string
    })
    vpc = object({
      id = string
    })
    instance_type = string
  })
}
variable "s3" {
  type = object({
    bucket = string
    key    = string
  })
}
variable "tags" {
  type = object({
    CreatedBy = string
  })
}
variable "disable" {
  type = object({
    instance = bool
  })
}
variable "ami" { default = "" }