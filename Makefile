SHELL:=/bin/bash

TMP_DIR=/tmp/configure-my-os
VENV_DIR=${TMP_DIR}/.venv
GPG_FILE_TO_SIGN=${TMP_DIR}/foo.txt
SOURCE_VENV=. ${VENV_DIR}/bin/activate
# Reference: https://www.linuxquestions.org/questions/linux-general-1/how-to-make-shell-script-wait-for-key-press-to-proceed-687491/
WAIT_ENTER_KEY=read -p "Press Enter to continue..."

.SILENT:
.ONESHELL:

.venv:
	echo "Setup environment before start..."
	mkdir -p ${TMP_DIR}
	test -d ${VENV_DIR} || python -m venv ${VENV_DIR}
	${SOURCE_VENV}
	pip install --upgrade pip -q
	pip install -r requirements.txt -q
	ansible-galaxy collection install kewlfft.aur

help:
	echo "####################################### Configure my os help #######################################"
	echo "Options:"
	echo "- system-apps: Install system-wide applications (accessible by all users)."
	echo "- graphic-card: Install applications and settings for NVidia graphics cards."
	echo "- user-apps: Install applications for current user."
	echo "- system-configs: Add some system-wide configurations."
	echo "- user-configs: Add some current user configurations."
	echo "- clean: Remove temporary script directory."
	echo "- ssh-and-gpg: Configure SSH and GPG keys, and save password on gnome keyring (seahorse)."
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

user-apps: .venv
	echo "Installing app on user scope..."
	${SOURCE_VENV}
	ansible-playbook user-apps-playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

system-configs: .venv
	echo "Installing my OS..."
	${SOURCE_VENV}
	ansible-playbook --ask-become-pass system-configs-playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

user-configs: .venv
	echo "Adding user configs..."
	${SOURCE_VENV}
	ansible-playbook user-configs-playbook.yml
	echo "Configuring fish shell..."
	deactivate
	curl -L https://get.oh-my.fish | fish
	echo "omf install spacefish" | fish
	chsh -s /usr/bin/fish
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

ssh-and-gpg:
	echo "Configuring SSH and GPG keys..."
	echo "Before continue, put the SSH keys to the \"~/.ssh\" directory"
	echo "and GPG keys to \"./gpg-keys\"."
	${WAIT_ENTER_KEY}

	echo "Configuring SSH keys..."
	echo "Enter the password for the \"personal\" SSH key (2 times)"
	ssh-add "${HOME}/.ssh/id_rsa_personal"
	# Automatic unlock using gnome keyring (seahorse)
	secret-tool store --label="Unlock password for: daniel.samrocha@gmail.com" "unique" "ssh-store:${HOME}/.ssh/id_rsa_personal"

	echo "Enter the password for the \"vago\" SSH key (2 times)"
	ssh-add "${HOME}/.ssh/id_rsa_vago"
	secret-tool store --label="Unlock password for: danielsan@vago.online" "unique" "ssh-store:${HOME}/.ssh/id_rsa_vago"

	echo "Configuring GPG keys..."
	echo "Enter the password for the \"daniel.samrocha@gmail.com\" GPG key (2 times)"
	touch ${GPG_FILE_TO_SIGN}
	gpg --import gpg-keys/gpg_pri_daniel-samrocha@gmail-com.asc
	gpg --import gpg-keys/gpg_pub_daniel-samrocha@gmail-com.asc
	echo "You will be directed to the GPG CLI, please, enter \"trust\" and select the option 5 (I trust ultimaly). So, press q to quit."
	gpg --edit-key daniel.samrocha@gmail.com
	echo "When the dialog appears, enter the password and check the option to save the password."
	${WAIT_ENTER_KEY}
	gpg -u A255F9F67FE8A090 --sign ${GPG_FILE_TO_SIGN}
	rm ${GPG_FILE_TO_SIGN}.gpg

	echo "Enter the password for the \"danielsan@vago.online\" GPG key (2 times)"
	gpg --import gpg-keys/gpg_pri_danielsan@vago-online.asc
	gpg --import gpg-keys/gpg_pub_danielsan@vago-online.asc
	echo "You will be directed to the GPG CLI, please, enter \"trust\" and select the option 5 (I trust ultimaly). So, press q to quit."
	gpg --edit-key danielsan@vago.online
	echo "When the dialog appears, enter the password and check the option to save the password."
	${WAIT_ENTER_KEY}
	gpg -u 50BB6C5665791EC0 --sign ${GPG_FILE_TO_SIGN}
	rm ${GPG_FILE_TO_SIGN}.gpg

clean:
	rm -rf ${TMP_DIR}
