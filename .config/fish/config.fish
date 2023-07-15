if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Vars #
    export EDITOR=nvim

    # Prompt #
    starship init fish | source

    # Aliases #
    alias vim="nvim"

    alias ls="logo-ls"

    alias rel="xrdb merge ~/.Xresources && kill -USR1 $(pidof st)"

    # Other #
    
    ## Disable Greeting Message ##
    set fish_greeting ""
  end
