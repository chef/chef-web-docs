1. Create a file named `skill-assembly.json` and paste in the following skill assembly definition:

   {{% readfile file="_vendor/github.com/chef/samples/cohorts/skill-assembly.json" highlight="json" %}}

   Replace each skill's version number with the version supported by the version of Chef 360 Platform that you're running. See the [Chef 360 Platform 1.2 release notes](https://docs.chef.io/360/1.2/release_notes) for the current supported skill versions.

1. Create the skill assembly:

    ```sh
    chef-node-management-cli management assembly create-assembly --body-file skill-assembly.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

    The response is similar to the following:

    ```json
    {
    "item": {
        "skillAssemblyId": "e2e66c8a-79ff-4bdc-a4cd-739c3f02f9e9"
      }
    }
    ```

    Save the value of `skillAssemblyId`, you will use it to create a node cohort.
