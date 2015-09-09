# .bash_profile for sysconfig

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc. System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.

if [ -f "$HOME/.inputrc" ] ; then
  source $HOME/.inputrc
fi

if [ -f "$HOME/.bashrc" ] ; then
  source $HOME/.bashrc
fi

if [ -f "$HOME/.nvm/nvm.sh" ] ; then
  source $HOME/.nvm/nvm.sh
fi

if [ -f "$HOME/.localrc" ] ; then
  source $HOME/.localrc
fi

if [ -d "$HOME/bin" ] ; then
  pathprepend $HOME/bin
fi

# Personal environment variables
export PS1='\[\e[0;32m\]\W\[\e[m\] $ ';
export PATH="/usr/local/sbin:$HOME/bin:$HOME/.rvm/bin:$PATH";
export EDITOR=vim;
export BROWSER=open;
export COMMAND_MODE=unix2003;
export NODE_ENV=development
export NODE_PATH="/usr/local/lib/node_modules";
export VIM_BINARY="/usr/local/bin/vim";
export MVIM_BINARY="/usr/local/bin/mvim";
export VIMRC="$HOME/.vimrc";

# Personal startup programs
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a alias*
eval "$(hub alias -s)"
if [ -f `brew --prefix`/usr/local/etc/bash_completion.d ]; then
  . `brew --prefix`/usr/local/etc/bash_completion.d
fi
