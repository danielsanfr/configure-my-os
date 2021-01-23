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

help:
	echo "####################################### Configure my os help #######################################"
	echo "Options:"
	echo "- system-apps: Install applications for all users of the system."
	echo "- graphic-card: Install applications and settings for NVidia graphics cards."
	echo "- user-apps: Install applications for current user."
	echo "- clean: Remove temporary script directory."
	echo "####################################################################################################"

system-apps: .venv
	echo "Installing my OS..."
	${SOURCE_VENV}
	ansible-playbook --ask-become-pass system-apps-playbook.yml
	# Some python apps may have this bug: https://github.com/Huluti/Curtail/issues/45
	deactivate
	yay -S --removemake --nodiffmenu --noconfirm curtail
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

clean:
	rm -rf ${TMP_DIR}
