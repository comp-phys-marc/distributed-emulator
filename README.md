# Heterogeneous Quantum Cloud Demo Repository (Python)

A minimal demonstration of a quantum cloud with mixed execution using Cirq, Qiskit, and a simple custom simulator.

## Bill C-27: Canada's First AI Legislation

Note that steps are being taken to make this software compliant with [Bill C-27](https://www.nortonrosefulbright.com/en-ca/knowledge/publications/55b9a0bd/bill-c-27-canadas-first-artificial-intelligence-legislation-has-arrived).

### Establishing measures to manage anonymized data

- On May 5th, 2022 suggested passwords, user and project names were [removed](https://github.com/comp-phys-marc/distributed-emulator/commit/4d227d0cc1564ee7370dd9b8d32f138c142e01aa) from the documentation

### Conducting an impact assessment to determine if the AI system is “high-impact” (a threshold that will eventually be defined by regulations)

- Hosting code on GitHub and GitLab allows for tracking of forks, downloads, etc.
- So far the source has very little usage excepting the TS language implementations whose usage is shown on [npm](https://www.npmjs.com/~marcusedwards)
- These TS components may be considered impactful in our opinion, but do not constitute AI technology without the adjoining software

### Maintaining general records of steps taken to meet compliance requirements and that describe how impact assessment conclusions are reached 

- 2FA used for each host account
- Record kept of ssh key cycling for source host account

# Modules

## [Emulator Common](https://gitlab.com/QuantumEmulator/emulatorcommon)

Submodule hosting messaging and database utilities shared across services.

## [QEElibrs](https://gitlab.com/QuantumEmulator/qeelibrs)

An original (albeit simple) state vector simulator implementation in Rust.

## [QEElib](https://gitlab.com/QuantumEmulator/qedlib)

An original (albeit simple) state vector simulator implementation in Python that works with IBMQX backends.

## [User Service](https://gitlab.com/QuantumEmulator/userservice)

A service that facilitates user management.

## [Simulation Service](https://gitlab.com/QuantumEmulator/simulationservice)

A scalable simulation service that makes use of qeelib to simulate distributed quantum algorithms.

## [Rust Simulation Service](https://gitlab.com/QuantumEmulator/rustsimulationservice)

A scalable simulation service that makes use of qeelibrs to simulate distributed quantum algorithms.

## [API Service](https://gitlab.com/QuantumEmulator/apiservice)

A service that facilitates authentication and programmatic use of the cloud execution environment.

# Setup

### Install Git

```
apt-get install git
```

## Repository

### Cloning

```
git clone https://gitlab.com/QuantumEmulator/distributedemulator.git --recurse-submodules
```

### Submodules

### Updating submodules

```
git submodule update --init --recursive
```

## Local development

## Install Docker Compose

Ubuntu 

```
curl -SL https://github.com/docker/compose/releases/download/v2.32.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## Install PSQL Client

Mac

```
brew install postgresql
brew services start postgresql
```

Ubuntu

```
sudo apt-get update
sudo apt-get install postgresql-client
```

## Setup the virtualenv

```
pip install virtualenv
pip install virtualenvwrapper
mkdir venv
cd venv
virtualenv . --python=python3
```

## Activate the virtualenv

```
source venv/bin/activate
```

## Install and start RabbitMQ

Mac

```
brew update
brew install rabbitmq
brew services start rabbitmq
/opt/homebrew/sbin/rabbitmqctl enable_feature_flag all

rabbitmq-plugins enable rabbitmq_management

sudo rabbitmqctl add_user SA <password>
sudo rabbitmqctl set_user_tags SA administrator
sudo rabbitmqctl set_permissions -p / SA ".*" ".*" ".*"
```

Ubuntu

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

sudo rabbitmqctl add_user SA <password>
sudo rabbitmqctl set_user_tags SA administrator
sudo rabbitmqctl set_permissions -p / SA ".*" ".*" ".*"
```

Note: if you run rabbit on your host's 127.0.0.1 then you should set `RABBIT_HOST=host.docker.internal` in `.env`.

### building images locally

```
docker-compose build
```

### Scaling locally

```
docker-compose scale simulationservice=5
```

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

gcloud config set project <project-name>
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
gcloud compute instances create-with-container qeesimulation \
     --container-image gcr.io/${PROJECT_ID}/simulationservice:v1
```

## Updating a container

```
gcloud compute instances update-container qeesimulation \
    --container-image gcr.io/${PROJECT_ID}/simulationservice:v2
```

## Google Kubernetes

### Creating a GKE cluster

```
gcloud container clusters create qeeemucluster --num-nodes=4
gcloud container clusters get-credentials qeeemucluster
```

### Deploying an image

```
kubectl run qeesimulation-deployment --image=gcr.io/${PROJECT_ID}/simulationservice:v1 --port 8080
```

### Exposing a deployment

```
kubectl expose deployment qeesimulation-deployment --port 80 --target-port 8080
```

### Scaling a deployment

```
kubectl scale deployment qeesimulation-deployment --replicas=3
```

## Remote access

### Configure RabbitMQ compute engine firewall

Expose amqp port

```
gcloud compute firewall-rules create rule-allow-tcp-5672 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-5672 --allow tcp:5672
gcloud compute instances add-tags qeerabbit --zone us-east1-b --tags allow-tcp-5672
```

Expose management UI

```
gcloud compute firewall-rules create rule-allow-tcp-15672 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-15672 --allow tcp:15672
gcloud compute instances add-tags qeerabbit --zone us-east1-b --tags allow-tcp-15672
```

### Connecting to the PSQL database

You must connect from an authorized IP.

```
psql -h <database-address> -U postgres qeeemudb
password: <password>
```

### Connecting to a hosted container

```
gcloud compute --project "project-name" ssh --zone "us-east1-b" "qeerabbit"
```

## Exposing API container

```
gcloud compute firewall-rules create rule-allow-tcp-5000 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-5000 --allow tcp:5000
gcloud compute instances add-tags qeeapi --zone us-east4-c --tags allow-tcp-5000
```

# Manual Deployment

## Api service setup

From inside fresh GCP container:

```
sudo apt-get update
sudo apt-get install git
git clone https://gitlab.com/QuantumEmulator/apiservice.git
sudo apt-get upgrade python3.6
sudo apt-get install python3-setuptools
sudo easy_install3 pip
cd apiservice
sudo pip3 install -r requirements.txt
git submodule update --init --recursive
pyhton3 app.py
```

# Rust development

## Setup

Mac

```
brew install rustup
rustup-init
```

# Running Tests

Tests can be executed inside a running Docker container using:

```
docker exec distributedemulator-simulationservice-1 python -m unittest discover 
```

## License

Copyright 2024 Marcus Edwards

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at:

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
