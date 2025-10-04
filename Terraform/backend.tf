terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # REPLACE with your bucket
    key            = "blogify/${terraform.workspace}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"            # REPLACE with your locking table
    encrypt        = true
  }
}
