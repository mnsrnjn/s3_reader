# s3_reader
Creating a lambda to log the contents of  text files from s3 bucket using terraform

Here the assignment.py contains the code to read the files and log the contents. This is written in python and boto3 module.

assignment.txt is the text file and will be uploaded to s3 and it is used for testing.

Steps:

1.clone the repository 
    git clone https://github.com/mnsrnjn/s3_reader.git

2. go to repo directory 
    cd s3_reader

3.Keep the access key and secret key ready  of the account where the resources will be created

4. initialise the terraform, it will download the required plugin and validate modules (modules are available locally)
    terraform init

5. Get the plan, what are the resources going to be created. provide the access key and secretkey when prompted .
    terraform plan

6. Now apply terraform to create the resources, and provide the access key and secretkey when prompted and yes to confirm and craete the resources.
    terraform apply



