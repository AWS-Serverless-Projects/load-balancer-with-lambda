terraform init
cd ./lambda
zip -r ../lambda.zip *
cd ..
terraform plan -out tfout.plan
terraform apply tfout.plan
