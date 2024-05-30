#!/bin/bash
set -eu

code-server --install-extension golang.go &

code-server --install-extension ms-python.python &

sudo useradd -m ${USER_NAME}

sudo chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME} 

sudo echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME}

sudo chsh -s $(which zsh)

su $USER_NAME --command "chsh -s $(which zsh)"

su $USER_NAME --command "code-server --auth none --bind-addr 0.0.0.0:8080 '/home/${USER_NAME}'"

#code-server --auth none --bind-addr 0.0.0.0:8080 "/home/${USER_NAME}"
