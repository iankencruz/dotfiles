# ~/.config/fish/functions/git.fish
function git
    # Check if the ssh-agent is already running using the plugin's function
    if not __ssh_agent_is_started
        # Start the agent and add keys if it's not running
        __ssh_agent_start
        ssh-add
    end

    # Now, execute the original git command with all arguments
    command git $argv
end
