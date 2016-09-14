.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Each profile consists of multiple files. Use an profile archive to simplify profile distribution by collecting all of these files into a single location. The |inspec| profile archive format supports:

 * |tar gz| and |gzip| (default)
 * |zip|

|inspec| profile archives

 * MUST be named with the standard suffix
 * MUST be a |tar gz| or |zip| formatted file
 * MUST not contain duplicate entries
 * MAY be compressed with |gzip|

Use ``inspec archive`` to create an archive of the target profile. By default, a |tar gz| file is generated on |unix| platforms and a |zip| file is generated on |windows| and |mac os x|.
