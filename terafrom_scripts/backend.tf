# Adding backend as s3 for remote state storage with state locking
backend "s3" {
    bucket = "terraform-test"
    key = "test/terraform.tfstate"
    region = "us-west-2"

    #for state locking
    dynamodb_table = "terraform-lock"
}
resource "aws_dynamodb_table" "tf_lock" {
    name = "terraform-lock"
    hash_key = "LockID"
    read_capacity = 3
    write_capacity = 3
    attribute {
        name = "LockID"
        type = "S"
    }
}
