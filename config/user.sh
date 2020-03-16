#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Creating SSH user.\033[0m\n"

usermod -a -G ssh progtest
echo "progtest:1234" | chpasswd
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/progtest/.profile

echo "progtest ALL=NOPASSWD:/bin/rm" >> /etc/sudoers
echo "progtest ALL=NOPASSWD:/bin/mkdir" >> /etc/sudoers
echo "progtest ALL=NOPASSWD:/bin/chown" >> /etc/sudoers
echo "progtest ALL=NOPASSWD:/usr/sbin/useradd" >> /etc/sudoers
echo "progtest ALL=NOPASSWD:/usr/sbin/deluser" >> /etc/sudoers
echo "progtest ALL=NOPASSWD:/usr/sbin/chpasswd" >> /etc/sudoers
 
exec "$@"
