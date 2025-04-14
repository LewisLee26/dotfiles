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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

abbr -a -- cat bat
abbr -a -- ls eza
abbr -a -- vi nvim
abbr -a -- push git push origin main
abbr -a -- pullr git pull origin main --rebase

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
