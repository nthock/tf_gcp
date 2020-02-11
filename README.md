# Sample Terraform Code for GCP

## Setting up

Create a service account in your GCP, and save the file as `gcp_credentials.json`.

```bash
terraform init

terraform plan

terraform apply
```

## Environment variables

Create a `.env` file and set your environment variables. Then source it.

For example:

.env
```
export TF_VAR_instance_name='EnvironmentJustin'
```

In your terraform code, define the variable:

```
variable "instance_name" {
  type    = string
}
```
The variable `EnvironmentJustin` will be available in `var.instance_name`.