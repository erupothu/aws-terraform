

#### state commands
> vi terraform.tfstate    
> terraform state list [options] [address]  
> terraform state list  
> terraform state list aws_s3_bucket.finance-20230810  

``` aws_s3_bucket.finance-2023810

resource 'aws_s3_bucket' 'terraform_state' {
  acl = "private"
  arn = "arn:aws:s3:::finance-20230810"
  bucket = "finance-20230810"
  bucket_domain_name = "finance-20230810.s3.amazon.com"
  bucket_regional_domain_name = "finance-20230810.s3.ap-south-1.amazon.com"
  force_destroy = false
  hosted_zone_d = ""
  id = "finance-20230810"
  region = "finance-20230810"
  request_player = "BucketOwner"
  tags = {
    "Description": "Bucket to store"
  }
  versioning = {
    enabled = false
    mfa_delete = false
  }
}
```

> terraform state mv [options] source destination
```statelocking.tf
resource 'aws_dynamodb_table' 'state-locking' {
  name = "state-locking"
  billing_mode = "PAY_PER_REQUEST'
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
```
> terraform state mv aws_dynamodb_table.state-locking aws_dynamodb_table.state-locking-db
> terraform state pull
> terraform state rm address
> terraform state rm finance-20230810

