.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A symbolic link---sometimes referred to as a soft link---is a directory entry that associates a file name with a string that contains an absolute or relative path to a file on any file system. In other words, "a file that contains a path that points to another file." A symbolic link creates a new file with a new inode that points to the inode location of the original file.

A hard link is a directory entry that associates a file with another file in the same file system. In other words, "multiple directory entries to the same file." A hard link creates a new file that points to the same inode as the original file.
