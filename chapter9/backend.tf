terraform {
    backend "s3" {
      bucket         = "tf101-jupiter-apne2-tfstate-yangro" # s3 bucket
      key            = "terraform_inflearn/chapter9/terraform.tfstate" # s3
      region         = "ap-northeast-2"  
      encrypt        = true
      dynamodb_table = "terraform-lock"
    }
}
