if status is-login
    set -gx fish_user_paths /home/sunny/.local/bin
end
if status is-interactive
    abbr --add -- grep 'grep --color=auto'
    abbr --add -- l 'ls -alh'
    abbr --add -- ll 'ls -l'
    abbr --add -- ls 'ls --color=tty'
    abbr --add -- lg lazygit

    set -U fish_greeting
    set -g fish_key_bindings fish_vi_key_bindings
end
