.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |resource chef_gem| and |resource package_gem| resources are both used to install |ruby| |gems|. For any machine on which the |chef client| is installed, there are two instances of |ruby|. One is the standard, system-wide instance of |ruby| and the other is a dedicated instance that is available only to the |chef client|. Use the |resource chef_gem| resource to install |gems| into the instance of |ruby| that is dedicated to the |chef client|. Use the |resource package_gem| resource to install all other |gems| (i.e. install |gems| system-wide).
