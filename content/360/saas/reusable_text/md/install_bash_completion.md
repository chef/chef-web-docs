Each Chef 360 Platform CLI has a `completion bash` subcommand. You must install the [bash-completion package](https://github.com/scop/bash-completion) to run these subcommands.

To install and configure the bash-completion package, follow these steps:

1. Install the bash-completion package.

   To install the bash-completion package on Linux systems, use the APT or Yum package manager:

    ```bash
    sudo apt-get install bash-completion
    ```

    or

    ```bash
    sudo yum install bash-completion
    ```

   To install the bash-completion package on macOS, use Homebrew:

    ```bash
    brew install bash-completion
    ```

1. Configure your Bash shell.

    To load the bash-completion package in every shell session by default, you must enable it in the `.bash_profile` or `.bashrc` file.

   To enable it on Linux systems, add the following lines to the `.bash_profile` or `.bashrc` file:

    ```bash
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
    ```

   To enable it on macOS, add the following lines to the `.bash_profile` or `.bashrc` file:

    ```bash
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
    ```

    or

    ```bash
    if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
        . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi
    ```
