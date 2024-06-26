#!/bin/bash
set -e

# source ROS workspace
source /opt/ros/$ROS_DISTRO/setup.bash

# exec as dockeruser with configured UID/GID
if [[ $DOCKER_UID && $DOCKER_GID ]]; then
    if ! getent group $DOCKER_GID > /dev/null 2>&1; then
        groupadd -g $DOCKER_GID $DOCKER_USER
    fi
    if ! getent passwd $DOCKER_UID > /dev/null 2>&1; then
        useradd -s /bin/bash \
                -u $DOCKER_UID \
                -g $DOCKER_GID \
                --create-home \
                --home-dir /home/$DOCKER_USER \
                --groups sudo,video \
                --password "$(openssl passwd -1 $DOCKER_USER)" \
                $DOCKER_USER && \
                touch /home/$DOCKER_USER/.sudo_as_admin_successful
        cp /root/.bashrc /home/$DOCKER_USER
        ln -s $WORKSPACE /home/$DOCKER_USER/ws
        chown -R $DOCKER_UID:$DOCKER_GID $WORKSPACE
        chown -R $DOCKER_UID:$DOCKER_GID /home/$DOCKER_USER
    fi
    [[ $(pwd) == "$WORKSPACE" ]] && cd /home/$DOCKER_USER/ws
    exec gosu $DOCKER_USER "$@"
else
    exec "$@"
fi
