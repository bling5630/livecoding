# Debian

## Install Using Stack

  * [Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/#debian)

### Binary Packages

The Debian Jessie main repository includes GHC 7.6.3 and cabal-install 1.20.  These are rather out of date.

The backports repository includes GHC 7.10.3 and cabal-install 1.22 which are much more current.

If you haven't previously enabled backports do that:

```
echo 'deb http://ftp.debian.org/debian/ jessie-backports main' | sudo tee /etc/apt/sources.list.d/bp.list
sudo apt-get update
```

Install both GHC and Cabal:

```
sudo apt-get update && apt-get -t jessie-backports install ghc cabal-install
```

Make sure to include `$HOME/.cabal/bin` on your `$PATH`:

```
cabal update && echo export PATH='$HOME/.cabal/bin:$PATH' >> $HOME/.bashrc
```

### Source Install

Install build dependencies:

```
apt-get update && apt-get install curl xz-utils build-essential libgmp-dev zlib1g-dev 
```


As a precaution I like to reset my `$PATH` to make sure no locally installed tools are used by mistake.

```
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Remove an artifacts that may exist from previous installations

```
rm -rf $HOME/.ghc
rm -rf $HOME/.cabal
```

In order to remove some of the repetition I define soem variables

```
export GHC_VER=8.0.1
export CAB_VER=1.24.0.0
export GHC_DIR="$ROOT_DIR/.ghc"
export CAB_DIR="$ROOT_DIR/.cabal"
export TMP_DIR="/tmp/ghc-install"
export GHC_FILE=ghc-$GHC_VER-x86_64-deb8-linux.tar.xz
export GHC_URL=http://downloads.haskell.org/~ghc/$GHC_VER/$GHC_FILE
export CAB_LIB_URL=https://www.haskell.org/cabal/release/cabal-$CAB_VER/Cabal-$CAB_VER.tar.gz
export CAB_APP_URL=https://www.haskell.org/cabal/release/cabal-install-$CAB_VER/cabal-install-$CAB_VER.tar.gz
```

create a tmp directory to work in

```
mkdir $TMP_DIR
```

First install GHC

```
# download ghc
curl -L $GHC_URL > $TMP_DIR/$GHC_FILE
# extract the tar file
cd $TMP_DIR && tar -xvf $GHC_FILE
# configure the project
cd $TMP_DIR/ghc-$GHC_VER && ./configure --prefix=$GHC_DIR
# build and install it
cd $TMP_DIR/ghc-$GHC_VER/ && make install
# add the newly installed GHC to the current path
export PATH=$GHC_DIR/bin:$PATH
```

You can check that it's installed

```
ghc --version
```

Install Cabal (the library)

```
curl -L $CAB_LIB_URL > $TMP_DIR/Cabal-$CAB_VER.tar.gz
# extract the tar file if necessary
cd $TMP_DIR && tar -xvf Cabal-$CAB_VER.tar.gz
# make setup 
cd $TMP_DIR/Cabal-$CAB_VER && ghc -threaded --make Setup.hs
# run configure
cd $TMP_DIR/Cabal-$CAB_VER && ./Setup configure --user --prefix=$CAB_DIR
# build and install the library
cd $TMP_DIR/Cabal-$CAB_VER && ./Setup build
cd $TMP_DIR/Cabal-$CAB_VER && ./Setup install 
```

INSTALL THE CABAL APPLICATION 

```
curl -L $CAB_APP_URL > $TMP_DIR/cabal-install-$CAB_VER.tar.gz
# extract the tar file if necessary
cd $TMP_DIR && tar -xvf cabal-install-$CAB_VER.tar.gz
# build and install the application if necessary 
cd $TMP_DIR/cabal-install-$CAB_VER && EXTRA_CONFIGURE_OPTS="" PREFIX=$HOME/.cabal ./bootstrap.sh
# make sure cabal is in the current path
export PATH=$CAB_DIR/bin:$PATH
# download package list if necessary
cabal update
```

ADD TO PATH

echo export PATH="$CAB_DIR/bin:$GHC_DIR/bin:\$PATH' >> $HOME/.bashrc
 
