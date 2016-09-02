# A Comprehensive Guide To Installing Haskell

There are a few ways to install Haskell depending on your goals.

  1. [Stack](#stack)
  2. [Binary Packages](#binary-packages)
  3. [Source](#from-source)

## Stack

In most situations, for most people, [Stack](https://docs.haskellstack.org/en/stable/README/) is the best installation choice.  Stack is a Haskell build tool.  It's able to manage multiple versions of Haskell packages and GHC on a per project or global basis.  It does require learning the Stack workflow but that burden is quite low given the advantages it provides.  Stack by default uses a fairly complete currated list of recent packages known to work together along with a modern version of GHC but does allow you to override these choices if necessary.

## Binary Packages

There are precompiled binary packages available for most operating systems.  These often lag behind the current release available from source.  This installation method is most appropriate if you're trying to following along with a tutorial or book that pre-dates Stack and don't want to learn stack or you're an experienced user who prefers Cabal sandboxes to Stack.  It's also worth mentioning that once the new [nix style build](http://ezyang.com/nix-local-build.html) system matures this may become a much more attractive choice.

  * [Debian Jessie](#binary-debian-jessie)

## From Source

Building from source is appropriate when there's no precompiled packages available for your operating system or the versions available are out of date.

  * [Debian Jessie](#source-debian-jessie)


### Binary Debian Jessie

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

### Source Debian Jessie

Install build dependencies:

```
sudo apt-get install build-essential ca-certificates libgmp10 libgmp-dev libffi-dev zlib1g-dev
```

As a precaution I like to reset my `$PATH` to make sure no locally installed tools are used by mistake.

```
export PATH=/usr/local/bin:/usr/bin:/bin
```

Remove an artifacts that may exist from previous installations

```
rm -rf $HOME/.ghc
rm -rf $HOME/.cabal
```

In order to remove some of the repetition I define soem variables

```
GHC_VER=8.0.1
CAB_VER=1.24.0.0
GHC_DIR="$ROOT_DIR/.ghc"
CAB_DIR="$ROOT_DIR/.cabal"
TMP_DIR="/tmp/ghc-install"
GHC_FILE=ghc-$GHC_VER-x86_64-deb8-linux.tar.xz
GHC_URL=http://downloads.haskell.org/~ghc/$GHC_VER/$GHC_FILE
```

First install GHC

```
# download ghc
mkdir -p $TMP_DIR
cd $TMP_DIR && curl -L $GHC_URL > $GHC_FILE
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
CABAL_URL=https://www.haskell.org/cabal/release/cabal-$CABAL_LIB_VER/Cabal-$CABAL_LIB_VER.tar.gz
$TMP_DIR && curl -L $CABAL_URL > Cabal-$CABAL_LIB_VER.tar.gz
# extract the tar file if necessary
cd $TMP_DIR && tar -xvf Cabal-$CABAL_LIB_VER.tar.gz
# make setup 
cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ghc -threaded --make Setup.hs
# run configure
cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup configure --user --prefix=$CABAL_DIR
# build and install the library
cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup build
cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup install 
```

INSTALL THE CABAL APPLICATION 

```
export CABAL_INSTALL_URL=https://www.haskell.org/cabal/release/cabal-install-$CABAL_APP_VER/cabal-install-$CABAL_APP_VER.tar.gz
curl -L $CABAL_INSTALL_URL > $TMP_DIR/cabal-install-$CABAL_APP_VER.tar.gz
# extract the tar file if necessary
cd $TMP_DIR && tar -xvf cabal-install-$CABAL_APP_VER.tar.gz
# build and install the application if necessary 
cd $TMP_DIR/cabal-install-$CABAL_APP_VER && EXTRA_CONFIGURE_OPTS="" PREFIX=$HOME/.cabal ./bootstrap.sh
# make sure cabal is in the current path
export PATH=$CABAL_DIR/bin:$PATH
# download package list if necessary
cabal update
```

ADD TO PATH
