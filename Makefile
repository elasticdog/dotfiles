pkgs_all := $(shell echo */)
pkgs_regular := git neovim tmux
pkgs_no_fold := fish ssh

cmd_install := stow --stow
cmd_uninstall := stow --delete

.PHONY: all
all: ;

.PHONY: install
install:
	$(cmd_install) $(pkgs_regular)
	$(cmd_install) --no-folding $(pkgs_no_fold)

.PHONY: install-linux
install-linux: install
	$(cmd_install) xorg xterm

.PHONY: install-macos
install-macos: install
	$(cmd_install) kitty macos

.PHONY: uninstall
uninstall:
	$(cmd_uninstall) $(pkgs_all)
