# Configure my OS

> Set of scripts for configuring my computers.

Throughout my **GNU/Linux** user journey I have used several distributions and desktop environments (_DE_). I am currently using [Manjaro Gnome](https://manjaro.org/download/#gnome) as the operating system.

In every distribution and every _DE_, I always tried to create a script for the repetitive task of reinstalling everything from scratch.

In this latest version, I'm using [Make](https://www.gnu.org/software/make) and [Ansible](https://www.ansible.com/) to automate things a little more.

## Usage

First, we need to install `make`, update and upgrade the system:

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

## Archive

- [Ubuntu](archive/ubuntu)
