## us-west-1 | demo

### Terraform remote state

```
terraform remote config \
    -backend=s3 \
    -backend-config="bucket=<replace_with_my_bucket>-us-west-1" \
    -backend-config="key=demo/terraform.tfstate" \
    -backend-config="region=us-west-1"
```
