if status is-interactive
    # Commands to run in interactive sessions can go here
    # Disable welcome message
    set -U fish_greeting

    # vi mode
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
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
zoxide init fish | source
