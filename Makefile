SHELL:=/bin/bash

TMP_DIR=/tmp/configure-my-os
VENV_DIR=${TMP_DIR}/.venv
SOURCE_VENV=. ${VENV_DIR}/bin/activate

.SILENT:
.ONESHELL:

.venv:
	echo "Setup environment before start..."
	mkdir -p ${TMP_DIR}
	test -d ${VENV_DIR} || python -m venv ${VENV_DIR}
	${SOURCE_VENV}
	pip install --upgrade pip -q
	pip install -r requirements.txt -q
	ansible-galaxy install kewlfft.aur

all: .venv
	echo "Installing my OS..."
	${SOURCE_VENV}
	ansible-playbook --ask-become-pass core-playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

graphic-card: .venv
	echo "Installing my OS (with graphic card support)..."
	${SOURCE_VENV}
	ansible-playbook --ask-become-pass graphic-card-playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

user-only: .venv
	echo "Installing my OS (with user only apps support)..."
	${SOURCE_VENV}
	ansible-playbook user-only-playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

# Some python apps may have this bug: https://github.com/Huluti/Curtail/issues/45
install-aur-python-apps:
	yay -S --removemake --nodiffmenu --noconfirm curtail

clean:
	rm -rf ${TMP_DIR}

help:
	echo "Configure my OS"
