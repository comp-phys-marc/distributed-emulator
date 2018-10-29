# Parent Repository (Python)

A container for all the services' repositories which are registered as submodules. This repo provides a simple way to pull and update all the others by simply pulling this repo and updating submodules.

# Setup

### Install Git:

```
apt-get install git
```

## Repository

### Cloning:

```
git clone https://gitlab.com/QuantumEmulator/distributedemulator.git --recurse-submodules
```

### Submodules

### Updating submodules:

```
git submodule update --init --recursive
```

## Local development

## Install PSQL Client:

```
sudo apt-get update
sudo apt-get install postgresql-client
```

## Setup the virtualenv:

```
pip install virtualenv
pip install virtualenvwrapper
cd venv
virtualenv .
```

## Activate the virtualenv:

```
source venv/bin/activate
```

## Install and start RabbitMQ:

```
sudo apt-get update
sudo apt-get upgrade
cd ~
sudo apt-get install erlang
echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install rabbitmq-server

sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service

sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

sudo rabbitmqctl add_user SA tercesdeqmis
sudo rabbitmqctl set_user_tags SA administrator
sudo rabbitmqctl set_permissions -p / SA ".*" ".*" ".*"
```

### building images locally:

```
docker-compose build
```

### Scaling locally:

```
docker-compose scale simulationservice=5
```

## Deployment tools setup:

### Install gcloud

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

gcloud config set project emulator-219302
gcloud config set compute/zone us-central1-b
```

### Install Kubernetes

```
sudo apt-get install kubectl
```

### Install Docker:

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

## Google Kubernetes

### Creating a GKE cluster

```
gcloud container clusters create qedemucluster --num-nodes=4
```

### Deploying a cluster

```
kubectl run qedsimulation-deployment --image=gcr.io/${PROJECT_ID}/simulationservice:v1 --port 8080
```

### Exposing a cluster

```
kubectl expose deployment qedsimulation-deployment --type=LoadBalancer --port 80 --target-port 8080
```

### Scaling a cluster

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
```
psql -d qedemudb -h 35.238.0.219 -p 5432 -U postgress
password: tercesdeqmis
```

### Connecting to the hosted RabbitMQ instance
```
gcloud compute --project "emulator-219302" ssh --zone "us-east1-b" "qedrabbit"
```
