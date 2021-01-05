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

all: .venv
	echo "Installing my OS..."
	${SOURCE_VENV}
	ansible-playbook --ask-become-pass playbook.yml
	echo ""
	echo "####################################################################################################"
	echo ""
	echo "Finish!"

clean:
	rm -rf ${TMP_DIR}

help:
	echo "Configure my OS"
