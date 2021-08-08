profile = "sandbox"
region  = "ap-northeast-1"
env     = "edu"
system  = "tf-demo"
aws = {
  subnet = {
    public = {
      az1 = {
        id = "subnet-08641ee3f0ecec84f"
      }
      az4 = {
        id = "subnet-03b921822c0bf51bd"
      }
    }
  }
  security_group = {
    ids = ["sg-077c66673841d54f7"]
  }
  key_pair = {
    name = "edu-demo-ssh-key"
  }
  vpc = {
    id = "vpc-0ea9c05a7b78f3bd4"
  }
  instance_type = "t2.micro"
}
s3 = {
  bucket = "edu-tfstate"
  key    = "dev/terraform.tfstate"
}
tags = {
  CreatedBy = "kano"
}
disable = {
  instance = false
}