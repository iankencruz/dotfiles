source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end



# --- Bun ---
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# --- Yazi File Manager Function ---
# This is a direct translation of the Zsh function
function y
	set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
    set -l cwd (cat $tmp)
	if test -n "$cwd"; and test "$cwd" != "$PWD"
        cd -- "$cwd"
    end
	rm -f -- "$tmp"
end

# Set the preferred editor globally
set -gx EDITOR "nvim"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
