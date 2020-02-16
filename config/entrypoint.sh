#!/bin/bash
set -e

# Entrypoint get executed at any launch of the container

# Create .vimrc if doesn't exist (important config is stored globally in /etc/vim/vimrc.local)
[[ -e /root/.vimrc ]] || echo "\"set nolist" >/root/.vimrc

if getent passwd "$1" >/dev/null 2>&1; then
    printf "\n\033[0;44m---> User already exists\033[0m\n"
else
    printf "\n\033[0;44m---> Creating SSH user.\033[0m\n"

    useradd -m -d /home/"$1" -G ssh "$1" -s /bin/bash
    echo "$1:$2" | chpasswd
    echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/$1/.profile
    
    echo "$1 ALL=NOPASSWD:/bin/rm" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/bin/mkdir" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/bin/chown" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/usr/sbin/useradd" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/usr/sbin/deluser" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/usr/sbin/chpasswd" >> /etc/sudoers
    echo "$1 ALL=NOPASSWD:/bin/bash" >> /etc/sudoers

    # Create .vimrc if doesn't exist
    [[ -e /home/$1/.vimrc ]] || echo "\"set nolist" >/home/$1/.vimrc
fi
 
printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"
 
service ssh start
service ssh status

# Prevent host system to stop docker if no action is provided
tail -f /dev/null
