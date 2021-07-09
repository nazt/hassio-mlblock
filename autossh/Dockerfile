ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY rootfs /

RUN apk add --no-cache  \
        openssh autossh nginx

RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

# COPY run.sh /
# RUN chmod a+x /run.sh

# CMD [ "/run.sh" ]