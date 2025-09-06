if status is-login; and status is-interactive
  # Add your SSH key paths here. Example:
  set -Ua SSH_KEYS_TO_AUTOLOAD ~/.ssh/id_ed25519
  # set -Ua SSH_KEYS_TO_AUTOLOAD ~/.ssh/other_key

  # Ensure keychain evaluates the output correctly for Fish
  keychain --eval $SSH_KEYS_TO_AUTOLOAD | source
end
