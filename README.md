# fedora-mock

![Docker Image CI](https://github.com/rhjhunt/fedora-mock/workflows/Docker%20Image%20CI/badge.svg)

A mock container image built on Fedora.

## Pull

You can pull from Quay.io:

```terminal
podman pull quay.io/rhjhunt/fedora-mock
```

You can also build your own:

```terminal
git clone https://github.com/rhjhunt/fedora-mock.git
cd fedora-mock
buildah bud -t rhjhunt/fedora-mock .
```

## Run

Create the directories to be used for the mock config files and mock build directory.

```terminal
mkdir -p ~/mock/{etc,var}
```

You can then run the container, since the `mock` command is the entrypoint you can pass any options relavent to `mock`.

```terminal
podman run --rm --privileged -v $HOME/mock/etc:/etc/mock:z \
-v $HOME/mock/var:/var/lib/mock:z \
-v $(pwd):/workdir quay.io/rhjhunt/fedora-mock
```

Or create an alias in your _~/.bashrc_ file.

```bash
alias mock='podman run --rm --privileged -v $HOME/mock/etc:/etc/mock:z -v $HOME/mock/var:/var/lib/mock:z 
-v $(pwd):/workdir quay.io/rhjhunt/fedora-mock'
```

You could then run the container using the alias of mock.

```terminal
mock --rebuild <NAME>.src.rpm
```