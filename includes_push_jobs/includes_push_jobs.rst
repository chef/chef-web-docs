.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|push jobs| is an extension of the |chef server| that allows jobs to be run against nodes independently of a |chef client| run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the |chef server|. 

|push jobs| uses the |api chef server| and a |ruby| client to initiate all connections to the |chef server|. Connections use the same authentication and authorization model as any other request made to the |chef server|. A |knife| plugin is used to initiate job creation and job tracking.
