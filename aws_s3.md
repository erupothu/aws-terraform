

```aws_s3_copy.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terrateam-test-bucket"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

```

new one

```aws_s3_new.tf
resource "aws_s3_bucket"

resource "aws_s3_bucket" "buckets" {
  for_each = local.buckets

  bucket = each.key
}

resource "aws_s3_bucket_public_access_block" "buckets" {
  for_each = local.buckets

  bucket = each.key
}

resource "aws_s3_bucket_ownership_controls" "buckets" {
  for_each = local.buckets

  bucket = each.key

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_website_configuration" "buckets" {
  for_each = local.buckets

  bucket = each.key

  index_document {
    suffix = "index.html"
  }
}
```
