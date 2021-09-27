#!/bin/bash

# This will stop the script when an error is returned from any of the CLI commands
set -e

# Set the internal field separator
IFS=$'\n'

# Define Variables for the DSM
export DSMAPIKEY=""
export DSM="dsm.trendmicro.com"
export DSMPORT="4119"

# Capture the WS Link ID
export ID=(`curl -k -s -X GET https://$DSM:$DSMPORT/api/workloadsecuritylinks \
-H "api-secret-key: $DSMAPIKEY" \
-H 'api-version: v1' | jq '.[][].ID'`)


# Delete the WS Link
curl -k -s -X DELETE https://$DSM:$DSMPORT/api/workloadsecuritylinks/$ID \
-H "api-secret-key: $DSMAPIKEY" \
-H 'api-version: v1' \
-H "Content-Type: application/json" \
-d '{ "workloadSecurityLinkID": "'$ID'"}'

echo ""
echo "The Workload Security Link was deleted successfully. The Link ID was ${ID}"
echo ""