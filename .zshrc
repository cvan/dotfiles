HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
DIRSTACKSIZE=50
cdpath=(. ~)

plugins=(git colored-man colorize pip python brew osx zsh-syntax-highlighting)

fpath=( ${HOME}/.zsh/func $fpath )
fpath=(/usr/local/share/zsh-completions $fpath)

export PYTHONDONTWRITEBYTECODE=1
export EDITOR=vim
export ACK_COLOR_MATCH=magenta

export WORDCHARS='*?_[]~=&;!#$%^(){}'

export ARCHFLAGS='-arch i386 -arch x86_64'
export HOSTNAME='system.local'
export LSCOLORS=dxfxcxdxbxegedabagacad
export LS_COLORS=LSCOLORS

export NODE_PATH="/usr/local/lib/node"
export PATH=/usr/local/share/python:$HOME/bin/:$HOME/:/usr/local/bin/:/usr/local/sbin/:/usr/local/share/npm/bin:/usr/local/:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs:$PATH

#export RBENV_ROOT=/usr/local/var/rbenv
#eval "$(rbenv init -)"

# Load aliases
if [[ -r ${HOME}/.aliasrc ]]; then
    eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliasrc`
fi

# Load profile
if [[ -r ${HOME}/.profile ]]; then
    source ${HOME}/.profile
fi

# # Load git_ps1
if [[ -r ${HOME}/.zsh/git-ps1 ]]; then
    . ${HOME}/.zsh/git-ps1
    #setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
    #precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
fi

# Enable color support of ls
#if [ "$TERM" != "dumb" ]; then
#    eval "`dircolors -b`"
#fi

psvar=()
# # Set the title to "user@host: directory"
case $TERM in
    (rxvt*|xterm*)
        precmd () {
            print -Pn "\e]0;%n@%m: %~\a"
            psvar[2]=$(__git_ps1)
        }
	;;
esac

# Set the prompt
RPS1=$'%{\e[34m%}%~%{\e[0m%}%{\e[35m%}%2v%{\e[0m%}'
PS1=$'%{\e[36m%}%v %{\e[0m%}'
case $HOST in
    (*)
        psvar="%";;
esac

if [[ $UID == 0 ]]; then
    psvar='##'
fi

# Set up completion
autoload -U compinit
compinit -i

# From zsh book
zstyle ':completion:*:warnings' format 'No matches: %d'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Show and group completions by description
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# From zsh-lovers
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${HOME}/.zsh/cache
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignored-patters '_*'

zstyle ':completion:*:default' list-colors  ${(s.:.)LS_COLORS}

setopt                  \
    aliases             \
    NO_all_export       \
    always_last_prompt  \
    NO_always_to_end    \
    append_history      \
    auto_cd             \
    auto_list           \
    auto_menu           \
    auto_name_dirs      \
    auto_param_slash    \
    auto_remove_slash   \
    auto_pushd          \
    NO_beep             \
    chase_dots          \
    chase_links         \
    NO_clobber          \
    correct             \
    extended_glob       \
    hash_cmds           \
    hash_dirs           \
    hash_list_all       \
    hist_find_no_dups   \
    hist_ignore_dups    \
    hist_ignore_all_dups\
    hist_verify         \
    inc_append_history  \
    list_ambiguous      \
    multios             \
    NO_overstrike       \
    pushd_ignore_dups   \
    pushd_minus         \

# Load keychain for ssh-agent
[[ -x /usr/bin/keychain ]] && /usr/bin/keychain -q ${HOME}/.ssh/id_rsa
[[ -f $HOME/.keychain/$HOST-sh ]] && source $HOME/.keychain/$HOST-sh

# Keybindings
bindkey -e
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey '\Cp'  history-beginning-search-backward
bindkey '\Cn'  history-beginning-search-forward
bindkey '\Cl'  forward-word
bindkey '\Ch'  backward-word

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g M='| most'
alias -g V='| view -'
alias -g A='| ack'

di () {
    diff $@ | vim -R -
}

mc () {
    mk $@ && cd $@
}

gig () {
    for f in $*
        echo $f >> ~/.gitignore
}

ff () {
    find . -name "*$1*"
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

echo 'Loaded `.zshrc`'

setopt EXTENDED_GLOB
ZSH_THEME="robbyrussell"

export PATH="/usr/local/opt/ruby/bin:$PATH"

# For compilers to find ruby you may need to set:
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

# For pkg-config to find ruby you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# If you need to have libpq first in your PATH run:
export PATH="/usr/local/opt/libpq/bin:$PATH"

# For compilers to find libpq you may need to set:
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"

# For pkg-config to find libpq you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"
