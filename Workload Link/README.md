# Creating a Link between your Deep Security Manager and your Cloud One Workload Security

In order to help you in the migration process from Deep Security to Cloud One Workload Security, this script to help you to prepare the migration from Deep Security to Cloud One Workload Security

## What does this script do?

This script will create a link between your Deep Security Manager and Cloud One Workload Security using the API.

## Requirements:

* **Cloud One Workload Security**:

    - Have a [Cloud One Workload Security](https://www.trendmicro.com/en_ae/business/products/hybrid-cloud/cloud-one-workload-security.html) account. [Sign up for a free trial now](https://cloudone.trendmicro.com/register) if it's not already the case!

    - An [API KEY](https://cloudone.trendmicro.com/docs/workload-security/api-key-create-console/) with **"Deep Security Migrations"** permission;

* **Deep Security Manager**:

    - An [API KEY](https://help.deepsecurity.trendmicro.com/20_0/on-premise/api-key.html) with **"Full Access"** permissions, for more details on roles, check this [link](https://help.deepsecurity.trendmicro.com/20_0/on-premise/user-roles.html);

    - Network access from the machine that you will execute the script to the Deep Security Manager;

    - This script was tested on **Deep Security Version 20.0.393**

* **General Requirements**:

    - This script was tested on **Centos 8.3.2011** and **Ubuntu 20.04.3 LTS** using a Docker container;

    - It require a [jq](https://stedolan.github.io/jq/) and [curl](https://curl.se/) installed on the machine that will execute the script;

## Usage

Clone this repository to the machine that you will use or download the ```create_wslink.sh```. Edit the file by setting the variables so the script will be able to execute API calls, these are the variables that you should set in the script:

```bash
# For Deep Security:
DSAPIKEY="My DSM API KEY"
DSM="My DSM URL or IP Address"
DSMPORT="My DSM port, eg. 4119"

# For Cloud One Workload Security:
APIKEY="My Cloud One API KEY"
REGION="My Cloud One Region, eg. US-1"
SERVICE="Destination service" # Is already set to workload so you don't need to change.
```

Then you're ready to execute the script:

```bash
root@1893e5fcdfb6 ./create_wslink.sh

Creating the Workload Security Link...

The Workload Security was created successfully. The Link ID is 10
```

In case you want to delete the Workload Security Link, you can execute the script here to delete:

```bash
root@1893e5fcdfb6 ./remove_wslink.sh

The Workload Security Link was deleted successfully. The Link ID was 10
```

PS.: Each Deep Security Manager tenant allows only one Workload Security Link

## Contributing

If you encounter a bug, think of a useful feature, or find something confusing
in the docs, please
[Create a New Issue](https://github.com/felipecosta09/DS-to-C1WS-mover/issues/new)!

We :heart: pull requests. If you'd like to fix a bug, contribute to a feature or
just correct a typo, please feel free to do so.

If you're thinking of adding a new feature, consider opening an issue first to
discuss it to ensure it aligns with the direction of the project (and potentially
save yourself some time!).

## Support

Official support from Trend Micro is not available. Individual contributors may
be Trend Micro employees, but are not official support.



