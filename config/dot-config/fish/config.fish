if status is-interactive
    abbr lg lazygit

    set -g fish_greeting
    set -g fish_key_bindings fish_vi_key_bindings
end
if status is-login
    set -gx DIRENV_LOG_FORMAT
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx SUDO_EDITOR nvim
    set -gx MANPAGER "nvim +Man!"
end

