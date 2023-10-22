if status is-interactive
    ##############################
    #        CREDIENTIALS        #
    ##############################
    source ~/.config/fish/credientials.fish

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
    export PATH="$HOME/.yarn/bin:$PATH"

    # Doomacs #
    export PATH="$HOME/.emacs.d/bin:$PATH"

    # Vimacs Mason PATH #
    export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

    ## Disable Greeting Message ##
    set fish_greeting ""

    ## Fish Vim Mode ##
    fish_vi_key_bindings # opposite of fish_default_key_bindings
  end
