# websiteTF
Working with Aws and Terraform

## Working with Workspace
1. Creating the Workspace

          terraform workspace new dev

2. Selecting the Workspace

          terraform workspace select dev

3. Running the Terraform in the given workspace

     terraform init
     terraform plan --var-file dev.tfvars

Note: Before you plan and apply the terraform, please add your credentials
      such as aws_access_key, aws_secret_key and your public_key
