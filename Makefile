pkgs_all := $(shell echo */)
pkgs_regular := git neovim ssh tmux
pkgs_no_fold := fish

cmd_install := stow --stow
cmd_uninstall := stow --delete

.PHONY: all
all: ;

.PHONY: install
install:
	@for package in $(pkgs_regular); do \
		$(cmd_install) $$package; \
	done
	@for package in $(pkgs_no_fold); do \
		$(cmd_install) --no-folding $$package; \
	done

.PHONY: install-osx
install-osx: install
	@$(cmd_install) osx

.PHONY: uninstall
uninstall:
	@for package in $(pkgs_all); do \
		$(cmd_uninstall) $$package; \
	done
