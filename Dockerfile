FROM almalinux:latest

ENV TZ="America/Chicago"
ENV CS_VER="4.89.1"
ENV k9s_VER="0.32.4"
ENV SOSP_VER="3.8.1"
ENV HOSTNAME="devbox"

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo 

RUN dnf update -y

RUN dnf install dnf-plugins-core -y && \   
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && \
    dnf install -y https://github.com/coder/code-server/releases/download/v$CS_VER/code-server-$CS_VER-amd64.rpm && \
    dnf install -y https://github.com/derailed/k9s/releases/download/v$k9s_VER/k9s_linux_amd64.rpm  && \
    dnf install -y https://github.com/getsops/sops/releases/download/v$SOSP_VER/sops-$SOSP_VER.x86_64.rpm && \
    dnf install -y vim ipmitool kubectl terraform sudo gh git zsh util-linux-user

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
