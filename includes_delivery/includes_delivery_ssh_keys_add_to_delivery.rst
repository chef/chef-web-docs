.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To add SSH keys to |chef delivery|, do the following:

#. Check for an SSH key:

   .. code-block:: bash

      $ cat .ssh/id_rsa.pub

   if it returns:

   .. code-block:: bash

      No such file or directory

#. Create an SSH key (without a passphrase):

   .. code-block:: bash

      $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

   The output is similar to:

   .. code-block:: bash

      Generating public/private rsa key pair.
      Enter file in which to save the key (/Users/username/.ssh/id_rsa): 
      Enter passphrase (empty for no passphrase): 
      Enter same passphrase again: 
      Your identification has been saved in /Users/path/to/.ssh/id_rsa.
      Your public key has been saved in /Users/path/to/.ssh/id_rsa.pub.
      The key fingerprint is:
      ac:8a:57:90:58:c1:cd:34:32:18:9d:f3:79:60:f3:41 your_email@chef.io
      The key's randomart image is:
      +--[ RSA 4096]----+
      |  .==*o.E        |
      |  . *o*..        |
      |   o + = .       |
      |  . o o.o        |
      |     . ..S       |
      |      ..         |
      |     ..          |
      |   .*o*.         |
      |  ...            |
      +-----------------+

#. Run the following:

   .. code-block:: bash

      $ cat .ssh/id_rsa.pub

   The output is similar to:

   .. code-block:: bash

      ssh-rsa
      AAAAB3NzaC1yc2EAAAADAQABAAACAQDa8BR/9bj5lVUfQP9Rsqon5qJMkiVm+JAtGi
      wnhxqgyRhkYLIzm6+gcifDgMOMuwZA88Ib5WNRhxjlmTseapower4rH/jAAczdp1h1
      7xLEEbUfQfkcqiy/Drp3k12345678ad234fgvdsasdfasdfR9ddNIeNvQ7OIpOCfLE
      PCyFz3aRRuhpM/5cySFT7bl1O44bNgfiuqRzcXFscZb03WPlhaPwCvL2uxaRzdrAGQ
      mE5jzCo6nORvKoGdVDa2++def33f3xPZCo3oJ08Q9XJ2CnfJlmyNe1hwI2NOQ3yRbc
      nfSMona7ccSyHRWGs5bS//u6P0NK5AqH5jK8pg3XwtHZqLwUVy1wX0WnnJWg9IWXf3
      2g3P4O4NJGVUeX33Czv32GK8YphuEweqFu/Ej7kQp1ppIxkEtrpBfMi3na0QqZlk6w
      wghZLa++DUfWOhGsuuBgnsocAR5rLGy+gkypdie1Ydoe8qjLVZR/jKybQfQjuZOS30
      fZnwJhl2ZaeraPfkEXlVhK02/8PIALGfeXdt9KvQN0p5c6lRoDxqBqslM+1KbKKcGd
      lSGEsAIP9OOWBECRxlOwqlqGHtrgWKOr376dntMIy2+fFD/74tJMjRwbRzm8IGWmj6
      OcF6EvTYYO4RmISD8G+6dm1m4MlxLS53aZQWgYWvRdfNB1DA
      Zo3h9Q== your_email@chef.io

#. Copy the SSH key and add it to |chef delivery|.

   Log into the |chef delivery| web UI as an administrator.

   Select **Users** from the drop-down menu on the upper right.

   On the **Users** list page, select the user name; use the search filter in the upper right if needed.

   Under **Security Information**, paste the SSH key.

   Click **Save & Close**.

#. Setup |chef delivery| for that user. Run the following:

   .. code-block:: bash

      $ delivery setup --server SERVER_DNS --user USERNAME --ent ENTERPRISE --org ORGANIZATION

   The output is similar to:

   .. code-block:: bash

      Chef Delivery
      Loading configuration from /Users/USERNAME
      Writing configuration to /Users/USERNAME/.delivery/cli.toml
      New configuration
      -----------------
      api_protocol = "https"
      enterprise = "ENTERPRISE"
      git_port = "8989"
      organization = "ORGANIZATION"
      pipeline = "master"
      server = "SERVER_DNS"
      user = "USERNAME"

#. Clone a repo from |chef delivery|:

   .. code-block:: bash

      $  delivery clone PROJECT_REPO

   The output is similar to:

   .. code-block:: bash

      Chef Delivery
      Loading configuration from /Users/USERNAME/Desktop
      Cloning ssh://USERNAME@chef@SERVER_DNS:8989/ENTERPRISE/ORGANIZATION/PROJECT to PROJECT
      The authenticity of host '[SERVER_DNS]:8989 ([10.100.10.50]:8989)' can't be established.
      RSA key fingerprint is 42:8d:92:31:9e:55:b0:06:28:b7:35:a9:4a:87:47:9d.
      Are you sure you want to continue connecting (yes/no)? yes
      adding remote delivery: ssh://USERNAME@ENTERPRISE@SERVER_DNS:8989/ENTERPRISE/ORGANIZATION/PROJECT

The user can now create a local branch, make and submit changes to |chef delivery|.
  