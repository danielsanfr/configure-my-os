# Configure my OS

> Set of scripts for configuring my computers.

Throughout my **GNU/Linux** user journey I have used several distributions and desktop environments (_DE_). I am currently using [Manjaro Gnome](https://manjaro.org/download/#gnome) as the operating system.

In every distribution and every _DE_, I always tried to create a script for the repetitive task of reinstalling everything from scratch.

In this latest version, I'm using [Make](https://www.gnu.org/software/make) and [Ansible](https://www.ansible.com/) to automate things a little more. To install AUR packages I use [ansible-aur](https://github.com/kewlfft/ansible-aur) with [yay](https://github.com/Jguer/yay).

## Usage

First, we need to install `make` and `yay`, update and upgrade the system:

```bash
./setup.sh
```

> If you have a kernel update, it is recommended that you reboot your computer.

Now we are all set to start the OS setup and application installation script:

```bash
make
```

### Dependencies

- make

## Manual Step

- [Edit GRUB config to show console output.](https://askubuntu.com/questions/477821/how-can-i-permanently-remove-the-boot-option-quiet-splash_)
- [Edit sudoers to show asterisks when type the password on the terminal.](https://www.howtogeek.com/194010/how-to-make-password-asterisks-visible-in-the-terminal-window-in-linux/)
- [Grub no reconoce mi partición Windows tras instalar linux-lqx 5.11.x](https://forum.manjaro.org/t/grub-no-reconoce-mi-particion-windows-tras-instalar-linux-lqx-5-11-x/56685/6)

## Archive

- [Ubuntu](archive/ubuntu)
