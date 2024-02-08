#! /bin/sh
set -xe

adduser --disabled-password --ingroup sudo --gecos "" $FIRSTUSER || echo "User $FIRSTUSER already exists"
echo "$FIRSTUSER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$FIRSTUSER-user
mkdir -p /home/$FIRSTUSER/.ssh &&\
    touch /home/$FIRSTUSER/.ssh/authorized_keys &&\
    chmod 700 /home/$FIRSTUSER/.ssh &&\
    chmod 600 /home/$FIRSTUSER/.ssh/authorized_keys &&\
    chown -R $FIRSTUSER: /home/$FIRSTUSER/.ssh