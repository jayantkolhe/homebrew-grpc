#!/bin/bash
#
# Installs gRPC the core in an existing Homebrew or Linuxbrew installation.
#
# prerequisites: Homebrew(Mac), Linuxbrew(Linux) is installed.
#
# Usage: curl -fsSL https://raw.githubusercontent.com/tbetbetbe/homebrew-grpc/master/scripts/install_grpc.sh | bash -

__grpc_check_for_brew() {
    which 'brew' >> /dev/null || {
        if [ "$(uname)" == "Darwin" ]; then
            echo "Cannot find the brew command - please ensure you have installed Homebrew (http://brew.sh)";
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
            echo "Cannot find the brew command - please ensure you have installed Linuxbrew (https://github.com/Homebrew/linuxbrew#installation)";
        else
            echo "Your system is neither a Mac nor Linux, so gRPC is not currently supported";
        fi
        return 1;
    }
}


__grpc_brew_install() {
    local pkg=${!#}
    if brew list -1 | grep -q "^${pkg}\$"; then
        echo "$pkg is already installed"
        return;
    else
        brew install $@
    fi
}

__grpc_install_with_brew() {
    # Explicitly install OpenSSL.
    if [ "$(uname)" != "Darwin" ]; then
        # there may be unresolved dependency issues installing openssl using linuxbrew on macs.
        __grpc_brew_install pkg-config
        __grpc_brew_install openssl
    else
        __grpc_brew_install openssl
    fi

    # On linux, explicitly install  unzip if it's not present, it's a protobuf dependency
    # TODO: add this to the official homebrew formula
    if [ "$(uname)" != "Darwin" ]; then
        which 'unzip' >> /dev/null || {
            brew tap homebrew/dupes
            __grpc_brew_install unzip
        }
    fi

    # Explicitly install protobuf.
    #
    # We need the alpha version of protobuf, that's currently packaged a devel package, and
    # for new we're installing the head version of gRPC
    # install it explicitly.
    __grpc_brew_install --devel protobuf

    # Install gRPC
    brew tap tbetbetbe/grpc
    __grpc_brew_install --HEAD grpc
}

main() {
    __grpc_check_for_brew || exit 1;
    __grpc_install_with_brew;
}

main
