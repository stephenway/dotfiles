alias tmux="TERM=screen-256color-bce tmux"

function mx() {
  if [[ -z $1 ]]; then
    SESSION=$(basename $PWD);
  else
    SESSION=$1
  fi

  if [[ -x $DOTFILES/tmux/workspaces/$SESSION ]]; then
    $DOTFILES/tmux/workspaces/$SESSION
  else
    if ! (tmux has-session -t $SESSION >/dev/null 2>&1); then
      tmux new-session -s $SESSION -n zsh -d
    fi

    tmux attach -t $SESSION
  fi
}

# Wrap ssh commmand to allow smart pane behavior in tmux.
#
# Lifted from https://github.com/moonboots/tmux-ssh/blob/master/tmux-sshrc
#
# After opening a tmux window and ssh-ing into another server, new panes will
# open already ssh-ed to the server.
function ssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv $session_variable_name "$*"

    # set window title
    tmux rename-window $*

    # run ssh
    /usr/bin/ssh $*

    # unset variable so new panes don't continue ssh-ing to this server
    tmux setenv -u $session_variable_name
  else
    /usr/bin/ssh $*
  fi

  # rename title back
  tmux rename-window zsh
}


