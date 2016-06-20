pkgs_all := $(shell echo */)
pkgs_regular := git neovim ssh tmux
pkgs_no_fold := fish

cmd_install := stow --stow
cmd_uninstall := stow --delete

.PHONY: all
all: ;

.PHONY: install
install:
	$(cmd_install) $(pkgs_regular)
	$(cmd_install) --no-folding $(pkgs_no_fold)

.PHONY: install-osx
install-osx: install
	$(cmd_install) osx

.PHONY: uninstall
uninstall:
	$(cmd_uninstall) $(pkgs_all)
