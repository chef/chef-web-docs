.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To add a project using the |chef delivery| web UI:

#. Log into the |chef delivery| web UI as user with **Admin** role.
#. Open the **Organizations** page and select your organization.
#. Click the plus sign (**+**) next to **Add a New Project**.

#. Enter a project name and select a **Source Code Provider**, either **Chef Delivery** (the default), **GitHub**, or **Bitbucket**:

#. If you choose **Chef Delivery**, simply click **Save and Close** to finish adding the project.

#. If you choose **GitHub**, a text area opens. Enter the following:

   **GitHub Organization Name**

   **GitHub Project Name**

   **Pipeline Branch** The name of the target branch that |chef delivery| will manage (most projects will have master as the target branch). The target branch must exist in the repository.

   **Verify SSL**  When selected, have |github| perform SSL certificate verification when it connects to |chef delivery| to run its web hooks.

#. If you choose **Bitbucket**, you must follow the integration steps in :doc:`Integrate Delivery with Bitbucket </integrate_delivery_bitbucket>` before you can add a project. After you have
done that you can add a new Delivery project through this webui by entering the Bitbucket project key, repository, and target branch information.

#. Click **Save and Close**.
