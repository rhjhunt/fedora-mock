FROM registry.fedoraproject.org/fedora-minimal:38

LABEL   name="fedora-mock" \
        version="2.0.1" \
        architecture="x86_64" \
        vcs-type="git" \
        vcs-url="https://github.com/rhjhunt/fedora-mock" \
        distribution-scope="public" \
        summary="mock provides an environment for building rpms." \
        maintainer="Jacob Hunt <jhunt@redhat.com>" \
        run="podman run --rm --privileged -v $HOME/mock/etc:/etc/mock:z -v $HOME/mock/var:/var/lib/mock:z -v $(pwd):/workdir rhjhunt/fedora-mock"

RUN microdnf -y update --nodocs --setopt install_weak_deps=0 && \
    microdnf -y install --nodocs --setopt install_weak_deps=0 rpmdevtools mock mock-core-configs && \
    microdnf clean all --enablerepo="*" && \
    mv /etc/mock /etc/mock-default && \
    mkdir /etc/mock && \
    useradd -c 'Mock Build' -G mock mockbuild && \
    mkdir /workdir

COPY macros.netshared /etc/rpm/
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/var/lib/mock", "/etc/mock", "/workdir"]

ENTRYPOINT ["/entrypoint.sh"]
