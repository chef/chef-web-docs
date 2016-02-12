.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The best practice for securing credentials like private keys, secrets, and certificates that are used with containers is to not store them within the container images. To support this best practice, |subcommand knife container| by default deletes these files upon the completion of the image build. The process for mounting or otherwise making these files available to the |chef client| varies, depending on the solution being used for containers.
