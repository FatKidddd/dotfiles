#!/usr/bin/env zsh

for d in *(/); stow -v -t ~ -S $d

# takopi post-install: copy template if no config exists
if [[ ! -f ~/.takopi/takopi.toml ]]; then
  cp ~/.takopi/takopi.toml.template ~/.takopi/takopi.toml
  echo "Created ~/.takopi/takopi.toml from template — fill in your secrets"
fi
