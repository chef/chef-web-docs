+++
title = "Run a Courier job on a node"

[menu.cloud]
title = "Run Courier jobs"
identifier = "chef_cloud/360/get_started/jobs"
parent = "chef_cloud/360/get_started"
weight = 110
+++

A Courier job defines the actions performed on a node or set of nodes, the schedule that the actions are performed on, and the group of nodes that the actions are performed on.
A job can be executed multiple times across multiple nodes for multiple actions.

## Prerequisites

- [Nodes are enrolled]({{< relref "enroll_nodes" >}}).

## Define a job

Jobs are defined using a job template, which is a file in JSON, YAML, or TOML format that tells Chef Courier the name of the job, when the job should run, the nodes that the job should run on, and the actions that the job should take.

This job template creates a job that's executed one node, it runs immediately, and it uses the `chef-platform/shell-interpreter` to run the `sleep 10` command.

- Create a file called `create-job-simple.json` and with the following JSON string:

  {{% readfile file="_vendor/github.com/chef/samples/courier-job-examples/create-job-simple.json" highlight="json" %}}

  Replace `<NODE_ID>` in the JSON file with the node identifier of your enrolled node.

## Create the job

When you add the job to Chef 360 SaaS, the Courier Dispatcher sends the job definition to the Courier Runner on the specified node which determines when and how to run the job.
You can submit a job definition using a JSON, YAML, or TOML file. The default format is JSON.

- Add the job run using the job template file:

  ```sh
  chef-courier-cli scheduler jobs add-job --body-file create-job-simple.json --profile <COURIER_OPERATOR_PROFILE_NAME>
  ```

  The default file format is JSON, you can also submit the job using YAML or TOML using the `--body-format` option. For example:

  ```sh
  chef-courier-cli scheduler jobs add-job --body-file create-job-simple.yaml --body-format yaml
  ```

  The response is similar to the following:

  ```json
  {
      "item": {
          "exceptionReasons": [],
          "id": "61013744-bd6e-437c-a995-b6211318624e",
          "nextExecutionTime": "2024-03-27T14:57:20.551342549Z"
      }
  }
  ```

  The output includes the job ID (`61013744-bd6e-437c-a995-b6211318624e` in the example response), which can be used to for tracking the job.

## Get the job instance details

A job instance is created every time the job executes. This job is set to run immediately, so only one job instance is created.

- Get the details of the job instance using the job ID:

    ```sh
    chef-courier-cli state instance list-all --job-id <JOB_ID> --profile <COURIER_OPERATOR_PROFILE_NAME>
    ```

    The response is similar to the following:

    ```json

    {
      "items": [
        {
          "actionSpec": {
            "accessMode": "agent",
            "steps": [
              {
                "command": {
                  "linux": [
                    "sleep 10"
                  ]
                },
                "conditions": [],
                "description": "",
                "expectedInputs": {},
                "failureBehavior": {
                  "action": "retryThenFail",
                  "retryBackoffStrategy": {
                    "arguments": [
                      1,
                      3,
                      5
                    ],
                    "delaySeconds": 0,
                    "type": "none"
                  }
                },
                "inputs": {},
                "interpreter": {
                  "name": "chef-platform/shell-interpreter",
                  "skill": {
                    "maxVersion": "",
                    "minVersion": "1.0.0"
                  }
                },
                "limits": {
                  "cores": 0,
                  "cpu": 1,
                  "timeoutSeconds": 0
                },
                "name": "sleep",
                "outputFieldRules": {},
                "retryCount": 2
              }
            ]
          },
          "createdAt": "2024-07-12T01:10:20.064474Z",
          "id": "befe88f3-ac3f-4bad-9e1a-6017332929ab",
          "jobId": "448ecaf3-5e44-4e7b-9e98-62dfa8c69b1c",
          "lastUpdatedBy": "00000000-0000-0000-0000-000000000000",
          "status": "running",
          "targetSpec": {
            "executionType": "sequential",
            "groups": [
              {
                "batchSize": {
                  "type": "number",
                  "value": 1
                },
                "distributionMethod": "batching",
                "filter": null,
                "filterId": "00000000-0000-0000-0000-000000000000",
                "listId": "00000000-0000-0000-0000-000000000000",
                "nodeIdentifiers": [
                  "1f4c680d-4dc6-4edf-83b6-ded81388f244",
                  "020ab866-9d3d-4ca7-919d-c21b4f9ef2a4",
                  "925f244c-65b4-4ab9-9ebd-4b17f8e2277b"
                ],
                "nodeListType": "nodes",
                "successCriteria": [
                  {
                    "numRuns": {
                      "type": "percent",
                      "value": 100
                    },
                    "status": "success"
                  }
                ],
                "timeoutSeconds": 60
              }
            ]
          },
          "updatedAt": "2024-07-12T01:10:20.064474Z"
        }
      ],
      "pagination": {
        "itemsPerPage": 10,
        "nextLink": "",
        "page": 1,
        "pageItemCount": 1,
        "previousLink": "",
        "startIndex": 1,
        "totalItems": 1,
        "totalPages": 1
      }
    }
    ```

    The response includes the job instance ID (`"id": "befe88f3-ac3f-4bad-9e1a-6017332929ab"`), which you can use to track the job instance.

## Get job run details

A job run is created for each target node in a job instance.

<!-- markdownlint-disable MD007 -->

- Request the details of each job run using the instance ID:

    ```sh
    chef-courier-cli state instance list-instance-runs --instanceId <INSTANCE_ID> --profile <COURIER_OPERATOR_PROFILE_NAME>
    ```

    The response is similar to the following:

    ```json
    {
        "items": [
            {
                "groupNumber": 0,
                "lastUpdateTime": "2024-03-27T15:00:09.185273Z",
                "nodeId": "03ba18c0-68b2-43ba-93fd-b6952443421e",
                "receivedTime": "2024-03-27T14:58:57.226555Z",
                "runId": "496f0d9a-f0be-4cb7-8cbb-2285b5c42045",
                "status": "success"
            },
            {
                "groupNumber": 0,
                "lastUpdateTime": "2024-03-27T14:58:48.582415Z",
                "nodeId": "2768a3b5-f5a6-45ae-a8b6-42d531c6416a",
                "receivedTime": "2024-03-27T14:57:51.753876Z",
                "runId": "306d3a00-d483-4aa2-bb09-1cd8c91c15e8",
                "status": "success"
            },
            {
                "groupNumber": 1,
                "lastUpdateTime": "2024-03-27T14:58:51.090507Z",
                "nodeId": "a8b1f470-fedc-45e8-ba0a-b26dd551c1d0",
                "receivedTime": "2024-03-27T14:57:49.229442Z",
                "runId": "376226b9-f916-42a1-8620-a4636598c5e5",
                "status": "success"
            },
            {
                "groupNumber": 1,
                "lastUpdateTime": "2024-03-27T14:59:58.186538Z",
                "nodeId": "acb38595-64af-4532-8589-2aeb2ad876fc",
                "receivedTime": "2024-03-27T14:58:55.934629Z",
                "runId": "22d7d6a9-33b5-4565-8575-2f2ee24a06a1",
                "status": "success"
            },
            {
                "groupNumber": 1,
                "lastUpdateTime": "2024-03-27T15:01:05.766027Z",
                "nodeId": "e4b1b524-4e77-4448-b1a9-01b80288c898",
                "receivedTime": "2024-03-27T15:00:03.220273Z",
                "runId": "56960929-ca32-463a-bc6e-c0a6cca4f89d",
                "status": "success"
            }
        ],
        "totalItems": 5
    }
    ```

    Each job run has a run ID. You can use the job run IDs to get information about each step of a job run.

    In this example, the run IDs are:

    - `"496f0d9a-f0be-4cb7-8cbb-2285b5c42045"`
    - `"306d3a00-d483-4aa2-bb09-1cd8c91c15e8"`
    - `"376226b9-f916-42a1-8620-a4636598c5e5"`
    - `"22d7d6a9-33b5-4565-8575-2f2ee24a06a1"`
    - `"56960929-ca32-463a-bc6e-c0a6cca4f89d"`

<!-- markdownlint-enable MD007 -->

## Get the job run step details for a run

- Use the job run ID to get a list of steps executed during a job run:

  ```sh
  chef-courier-cli state run list-steps --runId <RUN_ID> --profile <COURIER_OPERATOR_PROFILE_NAME>
  ```

  ```json
  {
      "items": [
          {
              "inputs": "",
              "interpreterPath": "/hab/pkgs/chef-platform/shell-interpreter/0.1.3/20240318113204/bin/shell-interpreter",
              "interpreterVersion": "",
              "numAttempts": 1,
              "outputs": "",
              "reason": "",
              "status": "success",
              "stepNumber": 1
          }
      ],
      "totalItems": 1
  }
  ```

## Debug Courier jobs

You can also review the job step details by connecting to a node with SSH and checking the Courier Runner logs.

For a Linux node:

```sh
cd /hab/svc/courier-runner/logs
tail -f courier-log
```

For a Windows node:

```powershell
cd C:\hab\svc\courier-runner\logs
gc .\courier-log -Wait
```
