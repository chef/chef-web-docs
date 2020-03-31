On Microsoft Windows systems the Chef Software Install script is invoked using
Windows PowerShell:

``` none
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install
```