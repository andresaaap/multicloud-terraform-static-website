# A Multi-Cloud Application

## Notes for the reviewer

Please go to the screenshots folder to see the images required in the rubric.

### DynamoDB selection support

**Availability: Requirement is global availability (Only AWS DynamoDB meets requirement)**
Availability is the assurance that an IT infrastructure has suitable recoverability and protection from system failures, natural disasters or malicious attacks. One important factor is geographical replication. Under high scalable pricing (non-provisioned) AWS [DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html) has availability in multiple regions (glocal) and [Azure CosmosDB](https://learn.microsoft.com/en-us/azure/cosmos-db/throughput-serverless) only runs in a single Azure region.

**Pricing: Requirement Highly scalable pricing (Azure CosmosDB has lower pricing)**
DynamoDB (on-demand capacity, Data storage size 1GB, 1 million writes / month + 1 million reads / month = 2 million operations / month): 
![DynamoDB pricing](https://github.com/andresaaap/multicloud-terraform-static-website/blob/main/dynamodb-decision-support/aws-pricing.png?raw=true)

Azure CosmosDB (serverless, Data storage size 1GB, 2 million RUs / month: 
![CosmosDB pricing](https://github.com/andresaaap/multicloud-terraform-static-website/blob/main/dynamodb-decision-support/azure-pricing.png?raw=true)

**Conclusions:** Only DynamoDB meets both requirements, therefore the decision is to choose AWS DynamoDB.

### Dependencies

```
- Terraform
- Azure
- AWS
```

### Installation

1. Open the AWS portal
    1. Open AWS CloudShell
    2. Run the following commands to install Terraform:
        1. `sudo yum install -y yum-utils`
        2. `sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo`
        3. `sudo yum -y install terraform`
    2. Clone your git repo
2. Open the Azure portal
    1. Open the Azure Cloud Shell
        1. Select PowerShell when prompted. Then click Show advanced settings on the next screen
        2. You can leave the resource group selected, but you’ll need to put in a name for the storage account and file share for your console. Name your storage account all lowercase with no dashes or punctuation. And less than 24 characters. Something like tscottocloudcstorage and tscottofileshare. Then click Create. Allow the console to provision. 
    2. Clone your git repo

### Instructions
1. With the requirements in mind, your team decided to use AWS S3 due to full S3 API compatibility. The team decided on Azure SQL and a dotnet web app due to Microsoft being the creators of both those technologies. You have the highest compatibility and support from Microsoft with both SQL and dotnet. Your team also wants to use AWS DynamoDB. Do some research using search engines, docs, and pricing calculators from both AWS and Azure to justify why your team chose AWS DynamoDB over Azure's counterpart. Limit your response to less than 150 words. Spend no more than 30 mins on this part. Add your explanation to your README.md file in your final repo submission.

2. Create a diagram based on your design for all 4 services. Note that directional arrows for the flow of traffic is not required.

3. Using the [above linked](#resources) references, add the appropriate modules to the given cloud provider Terraform scafolding files:
    1. AWS - `starter/aws/main.tf`
    2. Azure - `starter/azure/main.tf`
4. Edit the appropriate environment variables for the containers to test your install
    1. Find the following environment variables in the Terraform scaffolding and change their values to reflect your name:
        1. AWS_S3_BUCKET: `udacity-<your_name>-aws-s3-bucket`
        2. AWS_DYNAMO_INSTANCE: `udacity-<your_name>-aws-dynamodb`
        3. AZURE_SQL_SERVER: `udacity-<your_name>-azure-sql`
        4. AZURE_DOTNET_APP: `udacity-<your_name>-azure-dotnet-app`
5. Edit the Azure DNS for the container. Find this line in `starter/azure/main.tf` and replace `<your_name>` with your name:
    ```
      dns_name_label      = "udacity-tscotto-azure"
    ```
6. For Azure, edit the resource group name (line 2) to reflect the name the lab assigns to you. You can find your resource group name by typing `Resource Group` in the search bar in the Azure portal, select Resource Groups and see your unique group name. It will look similar to `Regroup_4hEF_2G`.
7. Services you select will be added after commented line `####### Your Additions Will Start Here ######` in the respective cloud provider `main.tf` file.
8. After you have added the modules, applies the changes to the files and push your changes to your github repositories
9. Pull a fresh copy of your github repository into your AWS and Azure Cloud Shells
10. In each shell, run the following:

    For AWS:
    ```
    cd cd11573-multicloud-computing-project/starter/aws
    terraform apply
    ```

    For Azure:
    ```
    cd cd11573-multicloud-computing-project/starter/azure
    terraform apply
    ```

    And type `yes` and enter when asked if you want to apply the changes
11. Wait for the changes to apply. This can take up to 20 min.
12. Verify the changes took effect:

    For Azure:
    1. In Azure go the search bar and type `container-instances` and click the icon that comes up
    2. Click `udacity-continst`
    3. Copy the URL from the field FQDN
    4. Paste that URL into another tab in your browser and add `:3000` onto the end of the URL. It will look something like this: `udacity-tscottoazure.westeurope.azurecontainer.io:3000`. Go to that URL. You should see this text in your browser (note the name will be yours):

                This is my app running on Azure accessing an S3 bucket in AWS: udacity-tscotto-s3-bucket

                And also accessing a dynamodb instance in AWS: udacity-tscotto-aws-dynamodb
    
    For AWS:
    1. In AWS go the search bar and type `load balancer` and click Load Balancers under the EC2 heading
    2. Click `udacity-lb`
    3. Copy the URL from the field DNS
    4. Paste that URL into another tab in your browser. It will look something like this: `udacity-lb-266017657.us-east-2.elb.amazonaws.com`. Go to that URL. You should see this text in your browser (note the name will be yours):

                This is my app running on AWS accessing an Azure SQL instance: tscotto-udacity-sql

                And also a dotnet app in Azure: udacity-tscotto-azure-dotnet-app
13. Please take a screenshot of a running web applications in a browser
14. Complete!
15. Clean up resources

    For AWS:
    ```
    cd cd11573-multicloud-computing-project/starter/aws
    terraform destroy
    ```

    For Azure:
    ```
    cd cd11573-multicloud-computing-project/starter/azure
    terraform destroy
    ```

    And type `yes` and press enter when asked if you want to destroy the resources
16. Please take a screenshot of the cloud console showing the successful Terraform destroy command


#### Troubleshooting Tips:
- In AWS you may only be able to run 1 or 2 exercises at a time. If you get an error in the AWS console about not having enough space or out of space, please run the following commands:
    - `cd ~`
    - `rm -rf *`

- In Azure, you may receive an error when provisioning your cloud console similar to "Storage Account Creation Failed" or "Authorization Failed". This is likely because you did not select the pre-created resource group from the lab. The pre-created resource group is already selected and is required for the labs. The pre-created resource group name will be similar to `Regroup_4hEF_2G`. When provisioning your cloud console, first select `Show advanced settings`, then ensure you leave the resource group as the default.

- In Azure, you may receive an error when running terraform about resource group creation failed. This is likely because you did not change the resource group name in the `main.tf` file to reflect your unique resource group name the Azure labs assign you. The resource group name will look similar to this: `Regroup_4hEF_2G`

## License

[License](LICENSE.txt)
