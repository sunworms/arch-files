if status is-interactive
    set -g fish_greeting
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_visual_block block
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_unknown block
end
