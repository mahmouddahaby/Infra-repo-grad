# Deploy backend application on K8S cluster using CI/CD jenkins pipline
## Project Requirement

![overview](https://user-images.githubusercontent.com/99130650/220208892-c15e032a-8c96-4ea1-9731-e40c6edd0f00.png)

-----------------------------

## Tools Used
- Terraform
- GCP 
- Kubernetes
- Jenkins 
- Docker
- Shell script

------------------------------------

## Getting Started

- Setup your GCP account
- Make sure to install required tools such as (Terraform, Docker)

---------------

## Prerequisites 

- Install Terraform
- GCP Account
- Master Jenkins Up and Running

---------------------

## Installation 

- Clone This Repo
- Configure your GCP credentials 
``` bash
gcloud auth login
```
- Build The Dockerfile and push it to GCR 
``` bash
gcloud auth configure-docker
docker login
docker build . -t gcr.io/<docker-username>/py-app
docker push gcr.io/<docker-username>/py-app 
```
- Run Terraform files
```bash
terraform init
terraform apply
```

- After Terraform Creation SSH into VM and install ***kubectl*** or any needed software like ***gcloud*** ( You can use Ansible to Automate this step )

- Connect to the GKE private cluster 
``` bash
gcloud container clusters get-credentials <cluster_name> --zone <zone> --project <project_id>
```
- Copy the provided k8s files and run them by:
```bash
kubectl apply -f <file-name>
```

- Run the following command to get the IP Adress of your Application
``` bash
kubectl get all 
```
- Copy the IP address of LoadBalancer and insert it in your browser to access the Application 

- Now Your Infrastructure & Application Is Up and Running !!


------------------------------------
### Jenkins file

  ```
- run `Kubectl get svc -n devops-tools` to get jenkins ip
- run `Kubectl exec -it po/jenkins-agent-<tail: pod name> -n devops-tools -- bash` to enter jenkins agent shell
- run `passwd jenkins` to make a password for the jenkins user
- run `chmod 666 /var/run/docker.sock` to make docker available to jenkins user
- run `service ssh start` to be able to connect to the agent
- run these command to install gcloud cli

  ```
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  apt-get update && apt-get install google-cloud-cli
  apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  ```

- run `su - jenkins` to switch to jenkins user
- run `gcloud auth configure-docker` to allow docker push to your priavte gcr
- run `gcloud container clusters get-credentials my-gke --region <your region> --project <your project name>` to generate kubeconfig file
- now with the password we created for the jenkins user add the jenkins agent to the list of jenkins node to be able to use it

This pipeline has three stages: Terraform Init, Terraform Plan, and Terraform Apply. The Terraform Init stage initializes Terraform, the Terraform Plan stage generates an execution plan for the infrastructure, and the Terraform Apply stage applies the execution plan to create the infrastructure on GCP.

The post section of the pipeline includes a Terraform destroy command, which ensures that the infrastructure is deleted after the pipeline is executed. This is useful for testing the pipeline without leaving any resources running unnecessarily.

Remember, to run this pipeline, you will need to configure your GCP personal credentials locally on the Jenkins master machine. You can do this by following the GCP documentation on setting up authentication for your environment.


Thank you







