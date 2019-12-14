#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Creating SSH user.\033[0m\n"

useradd -m -d /home/${SSH_USER_USERNAME} -G ssh ${SSH_USER_USERNAME} -s /bin/bash
echo "${SSH_USER_USERNAME}:${SSH_USER_PASSWD}" | chpasswd
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/${SSH_USER_USERNAME}/.profile
 
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/bin/rm" >> /etc/sudoers
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/bin/mkdir" >> /etc/sudoers
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/bin/chown" >> /etc/sudoers
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/usr/sbin/useradd" >> /etc/sudoers
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/usr/sbin/deluser" >> /etc/sudoers
echo "${SSH_USER_USERNAME} ALL=NOPASSWD:/usr/sbin/chpasswd" >> /etc/sudoers
 
exec "$@"
