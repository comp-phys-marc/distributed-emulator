# Prepare project

export PROJECT_ID="$(gcloud config get-value project -q)"

# Deploy

cd ../userservice
docker build -t gcr.io/${PROJECT_ID}/userservice:v1 .
docker push gcr.io/${PROJECT_ID}/userservice:v1
gcloud compute instances update-container qeduser --container-image gcr.io/${PROJECT_ID}/userservice:v1