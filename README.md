# dotfiles

My `.` files.

## Installation

1. Clone the repo:

        git clone git@github.com:cvan/dotfiles.git ~/.dotfiles/

2. Set up symlinks. Using zsh:

        for f (~/.dotfiles/.*) { ln -s $f ~/`basename $f` }

    Using bash:

        for f in ~/.dotfiles/.*; do ln -s $f ~/`basename $f`; done
