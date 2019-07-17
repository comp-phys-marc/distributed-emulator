# Prepare project

export PROJECT_ID="$(gcloud config get-value project -q)"

# Deploy

cd ../apiservice
docker build -t gcr.io/${PROJECT_ID}/apiservice:v1 .
docker push gcr.io/${PROJECT_ID}/apiservice:v1
gcloud compute instances update-container qedapi --container-image gcr.io/${PROJECT_ID}/apiservice:v1 --zone us-east4-c
