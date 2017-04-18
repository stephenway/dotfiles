# .bash_profile for sysconfig

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc. System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.

# Personal startup programs

pathprepend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}

sourcefile() {
  for ARG in "$@"
	do
	  if [ -f "$ARG" ] ; then
		  source $ARG
		fi
	done
}

pathprepend /usr/local/sbin
pathprepend /opt/pkg/bin
pathprepend $HOME/bin
sourcefile $HOME/.inputrc
sourcefile $HOME/.bashrc
sourcefile $HOME/.localrc

## SSH
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

## Autojump
[[ -s "/opt/pkg/share/autojump/autojump.sh" ]] && . /opt/pkg/share/autojump/autojump.sh
[[ -s "/opt/pkg/share/autojump/autojump.bash" ]] && . /opt/pkg/share/autojump/autojump.bash

# Personal environment variables

## Bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\e[0;32m\]\w\[\033[35m\] $(parse_git_branch)\[\e[m\]\nλ\[\033[00m\] '
export COMMAND_MODE=unix2003;
export BROWSER=open;
export PKGIN_PREFIX="/opt/pkg"
export ZOPFLI="/opt/pkg/bin/zopfli"

## Vim
export EDITOR=vim;
export VIM_BINARY="/usr/local/bin/vim";
export MVIM_BINARY="/usr/local/bin/mvim";
export VIMRC="$HOME/.vimrc";

## Node
export NODE_ENV=development
export NODE_PATH="/usr/local/lib/node_modules";

## GPG Keys
export GPG_TTY=$(tty)

