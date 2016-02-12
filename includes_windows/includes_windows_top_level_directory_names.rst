.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Paths can be longer in |unix| and |linux| environments than they can be in |windows|. |windows| will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory in |windows|, much like what is done in |unix| and |linux|. For example, |chef| uses ``/opt/`` to install the |chef dk| on |mac os x|. A similar approach can be done on |windows|, by creating a top-level directory with a short name. For example: ``c:\chef``.
