Directories that are used by Chef products on Windows can't have
spaces. For example, `C:\Users\User Name` won't work, but
`C:\Users\UserName` will. Chef commands may fail if used against a
directory with a space in its name.
