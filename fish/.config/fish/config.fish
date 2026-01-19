fish_config theme choose melange

if status is-interactive
    # Commands to run in interactive sessions can go here
    # Disable welcome message
    set -U fish_greeting

    # vi mode
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block
    fish_vi_key_bindings
end

# Export CUDA binaries into PATH
set -x PATH $PATH /usr/local/cuda-12.8/bin
# Export CUDA libraries into LD_LIBRARY_PATH
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/cuda-12.8/lib64
set -x XDG_CURRENT_DESKTOP GNOME

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f ~/miniforge3/bin/mamba
    eval ~/miniforge3/bin/mamba "shell" "hook" $argv | source
else
    if test -f "~/miniforge3/etc/fish/conf.d/mamba.fish"
        . "~/miniforge3/etc/fish/conf.d/mamba.fish"
    else
        set -x PATH "~/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<

abbr -a -- cat bat
abbr -a -- ls eza
abbr -a -- vi nvim

abbr -a -- mamba micromamba 

abbr -a -- gs git status --short
abbr -a -- gd git diff
abbr -a -- ga git add 
abbr -a -- gap git add --patch
abbr -a -- gc git commit 
abbr -a -- gp git push
abbr -a -- gu git pull
abbr -a -- gl git log --oneline
abbr -a -- gla git log --all --graph
abbr -a -- gb git branch
abbr -a -- gi git init
abbr -a -- gcl git clone
abbr -a -- gr git restore 

abbr -a -- gctrl 'gnome-control-center' 

bind -M default \cF accept-autosuggestion
bind -M insert -m default \cF accept-autosuggestion -m insert 

bind -M default \cP history-search-backward
bind -M default \cN history-search-forward
bind -M insert -m default \cP history-search-backward -m insert 
bind -M insert -m default \cN history-search-forward -m insert

bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
bind \cc true

zoxide init fish | source
starship init fish | source

fish_add_path /home/peteristaker/.pixi/bin
