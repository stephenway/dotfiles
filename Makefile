# SYSCONFIG INSTALL
# -------------------------------------

.DEFAULT_GOAL := all
CONFIG    := ${PWD}
VUNDLE    := ~/.vim/bundle/Vundle.vim

symlinks = config/fish \
	bin \
	gitconfig \
	gitignore_global \
	jshintrc \
	profile \
	ssh/config \
	tmux \
	tmux.conf \
	vimrc \

.PHONY: $(symlinks)

directories = vim/bundle/ \
	ssh/ \
	config/ \

.PHONY: $(directories)

COLOR = \033[32;01m
NO_COLOR = \033[0m

all: setup install

help:
	@echo "                                                     .d888 d8b          "
	@echo "                                                    d88P'  Y8P          "
	@echo "                                                    888                 "
	@echo ".d8888b  888  888 .d8888b   .d8888b .d88b.  88888b.  888888 888  .d88b.  "
	@echo "88K      888  888 88K      d88P'   d88''88b 888 '88b 888    888 d88P'88b "
	@echo "'Y8888b. 888  888 'Y8888b. 888     888  888 888  888 888    888 888  888 "
	@echo "     X88 Y88b 888      X88 Y88b.   Y88..88P 888  888 888    888 Y88b 888 "
	@echo " 88888P'  'Y88888  88888P'  'Y8888P 'Y88P'  888  888 888    888  'Y88888 "
	@echo "              888                                                    888 "
	@echo "         Y8b d88P                                               Y8b d88P "
	@echo "          'Y88P'                                                 'Y88P' "
	@echo
	@echo "   $(COLOR)make install$(NO_COLOR)		Install symlinks"
	@echo
	@echo "   $(COLOR)make setup$(NO_COLOR)		Install directories"
	@echo
	@echo "   $(COLOR)make check-dead$(NO_COLOR)	Find dead symlinks"
	@echo "   $(COLOR)make clean-dead$(NO_COLOR)	Delete dead symlinks"
	@echo "   $(COLOR)make update$(NO_COLOR)		Update sysconfig"
	@echo
	@echo "   $(COLOR)make all$(NO_COLOR)		Setup and install"

setup: rm -rf ~/.config/fish
	$(directories)
	chsh -s /usr/local/bin/fish
	[ -d ${VUNDLE} ] || git clone 'https://github.com/gmarik/Vundle.vim.git' ${VUNDLE}

$(directories):
	mkdir -p ~/.$@

install: $(symlinks)

$(symlinks):
	test -e $(CONFIG)/$@ && ln -sfn $(CONFIG)/$@ ~/.$@

check-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print

clean-dead:
	find ~ -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete

update:
	git pull --rebase
