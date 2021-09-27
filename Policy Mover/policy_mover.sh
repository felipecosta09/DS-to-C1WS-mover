#!/bin/bash

# This will stop the script when an error is returned from any of the CLI commands
set -e

# Set the internal field separator
IFS=$'\n'

# Define Variables for the DSM
export DSMAPIKEY=""
export DSM="dsm.trendmicro.com"
export DSMPORT="4119"

echo ""
echo "Migrating Policies to Workload Security..."
echo ""

# Create move task and collect the GUID
export POLICY_TASK_GUID=(`curl -k -s -X POST https://$DSM:$DSMPORT/api/policymigrationtasks \
-H "api-secret-key: $DSMAPIKEY" \
-H 'api-version: v1' | jq '.taskGUID' > /dev/null`)

# Collect the Status based on the GUID
export STATUS=(`curl -k -s -X POST https://$DSM:$DSMPORT/api/policymigrationtasks/search \
-H "api-secret-key: $DSMAPIKEY" \
-H 'api-version: v1' \
-H "Content-Type: application/json" \
-d '{   "maxItems": 1,  "searchCriteria":   [   { "fieldName": "taskGUID", "stringValue": "'$POLICY_TASK_GUID'" } ], "sortByObjectID": true }' | jq '.[][].status' | sed -e 's/^"//' -e 's/"$//'`)

echo "Moving in progress..."

# Loop to verify the status of the migration
while true
do
    if [[ $STATUS == "requested" ]]; then
        export STATUS=(`curl -k -s -X POST https://$DSM:$DSMPORT/api/policymigrationtasks/search \
        -H "api-secret-key: $DSMAPIKEY" \
        -H 'api-version: v1' \
        -H "Content-Type: application/json" \
        -d '{   "maxItems": 1,  "searchCriteria":   [   { "fieldName": "taskGUID", "stringValue": "'$POLICY_TASK_GUID'" } ], "sortByObjectID": true }' | jq '.[][].status' | sed -e 's/^"//' -e 's/"$//'`)
    elif [[ $STATUS == "failed" ]]; then
        export MOVE_FAILED=(`curl -k -s -X POST https://$DSM:$DSMPORT/api/policymigrationtasks/search \
        -H "api-secret-key: $DSMAPIKEY" \
        -H 'api-version: v1' \
        -H "Content-Type: application/json" \
        -d '{   "maxItems": 1,  "searchCriteria":   [   { "fieldName": "status", "stringValue": "failed", "fieldName": "taskGUID", "stringValue": "'$POLICY_TASK_GUID'" } ], "sortByObjectID": true }' | jq`)
        echo ""
        echo "Policy move failed! here is what was moved:"
        echo ""
        echo $MOVE_FAILED
        exit 0
    else
        echo ""
        echo "Policy was successfully moved!"
        echo ""
        exit 0
    fi
done