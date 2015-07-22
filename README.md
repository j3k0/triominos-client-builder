# Triominos Client Builder

This is a docker image than compiles and packages the triominos-client app for iOS and Android.

#### Usage

```sh
    # Prepare artifacts directory
    ARTIFACTS="`pwd`/artifacts/`date +%Y-%m-%d-%Hh%Mm%Ss`"
    mkdir -p "$ARTIFACTS"

    # Copy over the ssh key used to pull git repositories
    ID_RSA=`cat ~/.ssh/id_rsa | base64 -w0`
    ID_RSA_PUB=`cat ~/.ssh/id_rsa.pub | base64 -w0`

    # Go!
    docker run --rm --privileged -v "$ARTIFACTS:/artifacts" -e "ID_RSA=$ID_RSA" -e "ID_RSA_PUB=$ID_RSA_PUB" jeko/triominos-client-builder
```

#### SSH access

To checkout why anything could be going wrong, you can open the SSH access by adding `-p 2222:22` docker argument (exposing ssh on localhost port 2222).

