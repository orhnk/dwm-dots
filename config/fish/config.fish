if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Vars #
    export EDITOR=/bin/nvim

    # Prompt #
    starship init fish | source

    # Aliases #
    alias vim="nvim"

    alias ls="logo-ls"

    alias rel="xrdb merge ~/.Xresources && kill -USR1 $(pidof st)"

    # Other #

    # Enable True Color Support on ST #
    export COLORTERM=truecolor
    
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"

    # Doomemacs #
    export PATH="$HOME/.emacs.d/bin:$PATH"

    ## Disable Greeting Message ##
    set fish_greeting ""
  end
