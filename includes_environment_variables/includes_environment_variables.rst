.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In |unix|, a process' environment is a set of key-value pairs made available to the process. Often, programs expect their environment to contain information required for the program to run. The details of how these key-value pairs are accessed depends on the API of the language being used. This article explains how environments of child processes interact with their parent process and how to ensure that services and applications are started with the proper environment.
