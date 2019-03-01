# Prepare project

export PROJECT_ID="$(gcloud config get-value project -q)"

# Deploy services

./deploy_api.sh
./deploy_simulation.sh
./deploy_user.sh

# Update database connectivity

./update_db_connectivity.sh
