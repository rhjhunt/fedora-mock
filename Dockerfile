FROM registry.fedoraproject.org/fedora:33

LABEL   name="fedora-mock" \
        version="1.2" \
        architecture="x86_64" \
        vcs-type="git" \
        vcs-url="https://github.com/rhjhunt/fedora-mock" \
        distribution-scope="public" \
        summary="mock provides an environment for building rpms." \
        maintainer="Jacob Hunt <jhunt@redhat.com>" \
        run="podman run --rm --privileged -v $HOME/mock/etc:/etc/mock:z -v $HOME/mock/var:/var/lib/mock:z -v $(pwd):/workdir rhjhunt/fedora-mock"

RUN dnf -y --setopt=tsflags='' update && \
    dnf -y --setopt=tsflags='' install rpmdevtools mock mock-core-configs && \
    dnf clean all && \
    mv /etc/mock /etc/mock-default && \
    mkdir /etc/mock && \
    useradd -c 'Mock Build' -G mock mockbuild && \
    mkdir /workdir

COPY macros.netshared /etc/rpm/
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/var/lib/mock", "/etc/mock", "/workdir"]

ENTRYPOINT ["/entrypoint.sh"]
