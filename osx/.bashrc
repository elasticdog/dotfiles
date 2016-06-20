if [[ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
	source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
exec fish
