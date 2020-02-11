# Sample Terraform Code for GCP

## Setting up

Create a service account in your GCP, and download the credentials file.

Then, create a `.env` file and set your credentials: 

```
export GOOGLE_CLOUD_KEYFILE_JSON='{
  "type": <your-value>,
  "project_id": <your-value>,
  "private_key_id": <your-value>,
  "private_key": <your-value>,
  "client_email": <your-value>,
  "client_id": <your-value>,
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": <your-value>
}'
```

Then source it

```bash
source .env
```

Note that the key must be `GOOGLE_CLOUD_KEYFILE_JSON`. Terraform will automatically pick it up.

## Projects

There are different terraform setups available in this repo:
* Simple Web Server (`simple_web_server`): Set up a simple HTTP server
* Simple Docker (`simple_docker`): Set up the instance, and run a simple docker image (`gcr.io/cloud-marketplace/google/nginx1:1.12`)

To run the terraform code, cd into the respective folders (e.g. `cd simple_web_server`), and run the following:

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