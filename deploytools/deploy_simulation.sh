# Prepare project

export PROJECT_ID="$(gcloud config get-value project -q)"

# Deploy

cd ../simulationservice
docker build -t gcr.io/${PROJECT_ID}/simulationservice:v1 .
docker push gcr.io/${PROJECT_ID}/simulationservice:v1
gcloud compute instances update-container qedsimulation --container-image gcr.io/${PROJECT_ID}/simulationservice:v1
