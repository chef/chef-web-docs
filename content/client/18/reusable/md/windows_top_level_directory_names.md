Windows will throw errors when path name lengths are too long. For this
reason, it's often helpful to use a short top-level directory, much
like what's done in UNIX and Linux. For example, Chef uses `/opt/` to
install Chef Workstation on macOS. A similar approach can be done on
Windows, by creating a top-level directory with a short name.
For example: `C:\chef`.
