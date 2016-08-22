.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``os`` audit resource includes a collection of helpers that allow more granular testing of platforms, platform names, architectures, and releases.

Use any of the following platform-specific helpers to test for specific platforms:

* ``aix?``
* ``bsd?`` (including |darwin|, |freebsd|, |netbsd|, and |open bsd|)
* ``debian?``
* ``hpux?``
* ``linux?`` (including |alpine linux|, |amazon linux|, |archlinux|, |coreos|, |exherbo|, |fedora|, |gentoo|, and |slackware|)
* ``redhat?``
* ``solaris?`` (including |nexenta core|, |omnios|, |open indiana|, |solaris open|, and |smartos|)
* ``suse?``
* ``unix?``
* ``windows?``

For example, to test for |darwin| use:

.. code-block:: ruby

   describe os.bsd? do
      it { should eq true }
   end

To test for |windows| use:

.. code-block:: ruby

   describe os.windows? do
      it { should eq true }
   end

and to test for |redhat| use:

.. code-block:: ruby

   describe os.redhat? do
      it { should eq true }
   end

Use the following helpers may be used to test for operating system names, release, and architectures:

.. code-block:: ruby

   describe os.name do
      it { should eq 'foo' }
   end

.. code-block:: ruby

   describe os.release do
      it { should eq 'foo' }
   end

.. code-block:: ruby

   describe os.arch do
      it { should eq 'foo' }
   end
