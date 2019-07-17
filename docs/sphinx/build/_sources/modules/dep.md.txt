# Deploy Tools (Bash)

Bash scripts which automate the deployment of the system's microservices, performing most of the steps below.

## Deployment tools setup

### Install gcloud

Mac

```
https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-234.0.0-darwin-x86_64.tar.gz
./google-cloud-sdk/install.sh
```

Ubuntu

```
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

gcloud init

gcloud config set project beaming-signal-231717
gcloud config set compute/zone us-central1-b
```

### Install Kubernetes

Mac

```
brew install kubernetes-cli
```

Ubuntu

```
sudo apt-get install kubectl
```

### Install Docker:

Mac

```
https://download.docker.com/mac/beta/Docker.dmg
gcloud auth configure-docker
```

Ubuntu

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce

gcloud auth configure-docker
```

### Install docker compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Building images

```
export PROJECT_ID="$(gcloud config get-value project -q)"

cd ./apiservice
docker build -t gcr.io/${PROJECT_ID}/apiservice:v1 .

cd ../userservice
docker build -t gcr.io/${PROJECT_ID}/userservice:v1 .

cd ../simulationservice
docker build -t gcr.io/${PROJECT_ID}/simulationservice:v1 .

cd ../analysisservice
docker build -t gcr.io/${PROJECT_ID}/analysisservice:v1 .

docker push gcr.io/${PROJECT_ID}/simulationservice:v1
docker push gcr.io/${PROJECT_ID}/userservice:v1
docker push gcr.io/${PROJECT_ID}/apiservice:v1
docker push gcr.io/${PROJECT_ID}/analysisservice:v1
```

## Google Container Engine

### Deploying an image

```
gcloud compute instances create-with-container qedsimulation \
     --container-image gcr.io/${PROJECT_ID}/simulationservice:v1
```

## Updating a container

```
gcloud compute instances update-container qedsimulation \
    --container-image gcr.io/${PROJECT_ID}/simulationservice:v2
```

## Google Kubernetes

### Creating a GKE cluster

```
gcloud container clusters create qedemucluster --num-nodes=4
gcloud container clusters get-credentials qedemucluster
```

### Deploying an image

```
kubectl run qedsimulation-deployment --image=gcr.io/${PROJECT_ID}/simulationservice:v1 --port 8080
```

### Exposing a deployment

```
kubectl expose deployment qedsimulation-deployment --port 80 --target-port 8080
```

### Scaling a deployment

```
kubectl scale deployment qedsimulation-deployment --replicas=3
```

## Remote access

### Configure RabbitMQ compute engine firewall

Expose amqp port

```
gcloud compute firewall-rules create rule-allow-tcp-5672 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-5672 --allow tcp:5672
gcloud compute instances add-tags qedrabbit --zone us-east1-b --tags allow-tcp-5672
```

Expose management UI

```
gcloud compute firewall-rules create rule-allow-tcp-15672 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-15672 --allow tcp:15672
gcloud compute instances add-tags qedrabbit --zone us-east1-b --tags allow-tcp-15672
```

### Connecting to the PSQL database

You must connect from an authorized IP.

```
psql -h 35.227.110.153 -U postgres qedemudb
password: tercesdeqmis
```

### Connecting to a hosted container

```
gcloud compute --project "beaming-signal-231717" ssh --zone "us-east1-b" "qedrabbit"
```

### building images locally

```
docker-compose build
```

### Scaling locally

```
docker-compose scale simulationservice=5
```