.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

It is possible to capture the output of commands invoked by Push Jobs, both STDOUT and STDERR, by
providing the ``capture_output=true`` option when creating a job.

If capture is enabled, then the client will capture both the stdout and the stderr channels of the command.
he channel output will be sent back regardless of whether the command succeeded or failed. It will be sent in raw
form, including any terminating whitespace. If the command produced no output, then the value will be an empty string.

The two channels are treated as a pair -- for a given ``<job, node>``, either both will appear, or neither will appear.

The output is not streamed to the server as it is produced. Therefore, the output data for a given node will not
be available until the run on that node is complete.
