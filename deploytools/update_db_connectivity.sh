gcloud compute instances list > service_deployment_info.txt
IPS=`awk 'NR>1 { ORS = ","; print $5}' service_deployment_info.txt`
PRINTOUT="Authorizing IP addresses: $IPS"
echo $PRINTOUT
UPDATE_COMMAND="gcloud sql instances patch qeddb --authorized-networks=$IPS"
eval $UPDATE_COMMAND
