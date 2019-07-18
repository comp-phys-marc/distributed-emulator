# Api Service (Python)

A python service that facilitates communication between client applications, including the QEE web interface, and the backend services of the experiment engine.

## Api Setup

To install all requirements:

```
pip3 install -r requirements.txt
```

To start the service:

```
./run.sh
```

## Exposing API container

```
gcloud compute firewall-rules create rule-allow-tcp-5000 --source-ranges 0.0.0.0/0 --target-tags allow-tcp-5000 --allow tcp:5000
gcloud compute instances add-tags qedapi --zone us-east4-c --tags allow-tcp-5000
```

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