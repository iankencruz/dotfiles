source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end


wal -i ~/Pictures/Wallpapers/lucy.jpeg
# cat ~/.cache/wal/sequences &

alias vim='nvim'
alias task='go-task'
alias cd='z'
alias lg='lazygit'


# Init Zoxide
zoxide init fish | source



# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


set -x PATH $PATH /home/ianc/go/bin



set -gx PATH $HOME/.cargo/bin $PATH


set -gx FILE_MANAGER nautilus
set -gx TERMINAL_FILE_MANAGER yazi


set -gx EDITOR nvim
set -gx VISUAL /usr/bin/nvim





set -x XDG_CURRENT_DESKTOP Hyprland
set -x XDG_SESSION_DESKTOP Hyprland
set -x XDG_SESSION_TYPE wayland
