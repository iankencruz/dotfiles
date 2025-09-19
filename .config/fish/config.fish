source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
  sleep 0.1
  fastfetch
end

# Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end



alias vim='nvim'
alias task='go-task'
alias cd='z'
alias lg='lazygit'


# Init Zoxide
zoxide init fish | source



# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# Go 
set -x PATH $PATH /home/ianc/go/bin

# Rust
set -gx PATH $HOME/.cargo/bin $PATH

# File Managers
set -gx FILE_MANAGER nautilus
set -gx TERMINAL_FILE_MANAGER yazi

# Set Nvim as default
set -gx EDITOR nvim
set -gx VISUAL /usr/bin/nvim

# Hyprland as XDG default
set -x XDG_CURRENT_DESKTOP Hyprland
set -x XDG_SESSION_DESKTOP Hyprland
set -x XDG_SESSION_TYPE wayland




# Disable automatic startup of the ssh-agent
# set -g fish_ssh_agent_enabled false

# Init Oh-my-posh
oh-my-posh init fish --config ~/.config/ohmyposh/BurningMelo.toml | source
