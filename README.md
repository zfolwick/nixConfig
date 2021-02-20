# nixConfig
Linux Configuration files
Clone this repo, and then cd into the `nixconfig/` directory, then run `sudo ./bashConfigure`, sit back, and enjoy.

You get: htop, tmux, vim, emacs24, silversearcher-ag (faster grep), docker, better bashrc with git integration, and some reasonable configurations for the above.  Additionally, this assumes Ubuntu, so it installs the much lighter weight metacity, and gnome-session-flashback, which will allow you to choose your desktop environment upon startup.

## Prerequisites

Ubuntu 14.04+  
git  
a package manager: apt-get, [apt-cyg](https://github.com/transcode-open/apt-cyg).  If on a mac, then homebrew shall be installed for you.

## Other commands

`sudo ./bashConfigure install` re-installs everything
`sudo ./bashConfigure copy` creates symbolic links on your $HOME directory to the dotfiles
`sudo ./bashConfigure source` re-sources your dotfiles
`sudo ./bashConfigure cs` copies and sources your dotfiles
