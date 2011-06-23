echo "Reading ~/.bashrc ..."

export HISTCONTROL=erasedups
export HISTSIZE=7000
shopt -s histappend
alias ..="cd .."
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

oak() {
    curl -d "TERMS_ACCEPTED=1&ACCESS_CODE=A8Z689EPH2BS&STATUS=1&ROOM_NO=Virtual%20Room&ASSIGNED_IP=172.16.7.214&MAC_ADDRESS=78:ca:39:b7:8b:8d&FLAGS=3&PORT_ID=0&REG_TYPE=&VLAN_ID=0&UID=7267&MODE=2&STATUS=8384&SOLN_REG_TRANS_DT=zzzREG_TRANS_DTzzz&SOLN_REG_TRANS_KEY=zzzREG_TRANS_KEYzzz&REALIPS_ARE_GONE=0" http://soln-sr3694.solutionip.com/common_ip_cgi/oakwood_access.cgi
}

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '

export ARCHFLAGS='-arch i386 -arch x86_64'
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
export GREP_OPTIONS="--exclude=*.svn*"

alias d="ssh dekkostudios.com@dekkostudios.com"
alias p="ssh cwiemeersch@people.mozilla.org"

source /usr/local/etc/bash_completion.d/git-completion.bash

export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.virtualenvwrapper

export ZAMBONI_PATH=~/Sites/projects/zamboni

z() {
    cd $ZAMBONI_PATH
    workon zamboni
}

zup() {
    z
    echo "Updating master ..."
    git checkout master && git pull && git submodule update --init
    echo "Updating vendor ..."
    pushd vendor && git pull && git submodule update --init && popd
    echo "Running migrations ..."
    ./vendor/src/schematic/schematic migrations
}

export PATH="/usr/local/bin:$PATH:/usr/local/sbin"
export HOSTNAME='system.local'
