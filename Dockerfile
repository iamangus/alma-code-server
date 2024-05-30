FROM almalinux:latest

ENV TZ="America/Chicago"
ENV CS_VER="4.20.1"

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo 

RUN dnf install dnf-plugins-core -y && \   
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && \
    curl -fOL https://github.com/coder/code-server/releases/download/v$CS_VER/code-server-$CS_VER-amd64.rpm && \
    rpm -i code-server-$CS_VER-amd64.rpm && \
    dnf install -y vim ipmitool kubectl terraform sudo gh git python-devel libffi-devel pip && \
    pip install sops

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
