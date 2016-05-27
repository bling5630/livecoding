#!/bin/bash

#
# exit on any error or unset var
#
set -eu

#
# version variables
#
GHC_VER=8.0.1
CABAL_LIB_VER=1.24.0.0
CABAL_APP_VER=1.24.0.0

#
# directories
#
ROOT_DIR="$HOME"
GHC_DIR="$ROOT_DIR/.ghc"
CABAL_DIR="$ROOT_DIR/.cabal"
TMP_DIR="/tmp/hvm"

#
# make sure the script is not being run as root
#
if [[ $EUID -eq 0 ]]; then
   echo "This script should be ran as a normal user, not root!" 1>&2
   exit 1
fi

#
# make sure we're on linux
#
KERNEL_NAME=$(uname -s)
if [ "$KERNEL_NAME" != "Linux" ]; then 
  echo "This script is intended to be executed on systems running Linux."
  exit 1
fi

#
# determine the distro name 
#
if [ -f /etc/os-release ]; then
  DISTRO_NAME=$(grep ^ID= /etc/os-release | cut -f 2 -d '=')
else
  DISTRO_NAME="unknown"
fi

#
# Make sure the distro is supported
#
case $DISTRO_NAME in
  debian)
    ;;
  ubuntu)
    ;;
  *)
    echo "This script is only intended to be executed on Debian based distributions, you"
    echo "will need to modify it to support other distributions."
    exit 1
esac

#
# Reset PATH to make sure we know what's being run.
#
export PATH=/usr/local/bin:/usr/bin:/bin

#
# Assume everythings going to work until it doesn't
#
abort=false

#
# Check to make sure required packages are installed.
#
packages=(build-essential ca-certificates libgmp10 libgmp-dev libffi-dev zlib1g-dev)
for package in ${packages[*]}; do
  if ! (dpkg-query -W -f='${Status} ${Version}\n' $package | grep 'install ok' >> /dev/null ); then
    abort=true
    echo "The package '$package' is required."
  fi
done

#
# Make sure $GHC_DIR does not already exist
#
if [[ -e "$GHC_DIR" ]]; then
  abort=true
  echo "Error, detected an existing $GHC_DIR directory."
fi

#
# Make sure $CABAL_DIR does not already exist
#
if [[ -e "$CABAL_DIR" ]]; then
  abort=true
  echo "Error, detected an existing $CABAL_DIR directory."
fi

#
# If an error was detected abort now.
#
if [ "$abort" = true ]; then
  echo "Aborting, previous installations must be entirely removed and all necessary packages dependencies must be installed before installation can proceed."
  exit
fi

#---------------------------------------------------------------------
#
# INSTALL GHC
#
#---------------------------------------------------------------------

# Compute the url for the ghc tar file.
GHC_FILE=ghc-$GHC_VER-x86_64-deb8-linux.tar.xz
GHC_URL=http://downloads.haskell.org/~ghc/$GHC_VER/$GHC_FILE

# download and install the newest version of ghc
if [[ ! -f $TMP_DIR/$GHC_FILE ]]; then
  mkdir -p $TMP_DIR
  cd $TMP_DIR && curl -L $GHC_URL > $GHC_FILE
fi

# extract the tar file
if [[ ! -d $TMP_DIR/ghc-$GHC_VER ]]; then
  cd $TMP_DIR && tar -xvf $GHC_FILE
fi

# configure ghc 
if [[ ! -f $TMP_DIR/ghc-$GHC_VER/config.log ]]; then
  cd $TMP_DIR/ghc-$GHC_VER && ./configure --prefix=$GHC_DIR
fi

# install ghc 
if [[ ! -e $GHC_DIR/bin/ghc ]]; then
  cd $TMP_DIR/ghc-$GHC_VER/ && make install
fi

# add the newly installed GHC to the current path
export PATH=$GHC_DIR/bin:$PATH

#---------------------------------------------------------------------
#
# INSTALL THE CABAL LIBRARY 
#
#---------------------------------------------------------------------

# Compute the url for the cabal library tar file.
CABAL_URL=https://www.haskell.org/cabal/release/cabal-$CABAL_LIB_VER/Cabal-$CABAL_LIB_VER.tar.gz

# download the tar file if necessary
if [[ ! -f $TMP_DIR/Cabal-$CABAL_LIB_VER.tar.gz ]]; then
  mkdir -p $TMP_DIR
  cd $TMP_DIR && curl -L $CABAL_URL > Cabal-$CABAL_LIB_VER.tar.gz
fi

# extract the tar file if necessary
if [[ ! -d $TMP_DIR/Cabal-$CABAL_LIB_VER ]]; then
  cd $TMP_DIR && tar -xvf Cabal-$CABAL_LIB_VER.tar.gz
fi

# make setup 
if [[ ! -f $TMP_DIR/Cabal-$CABAL_LIB_VER/Setup ]]; then
  cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ghc -threaded --make Setup.hs
fi

# run configure
if [[ ! -d $TMP_DIR/Cabal-$CABAL_LIB_VER/dist ]]; then
  cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup configure --user --prefix=$CABAL_DIR
fi

# build and install the library
if [[ ! -d $CABAL_DIR/lib ]]; then
  cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup build 
  cd $TMP_DIR/Cabal-$CABAL_LIB_VER && ./Setup install 
fi


#---------------------------------------------------------------------
#
# INSTALL THE CABAL APPLICATION 
#
#---------------------------------------------------------------------

# Compute the url for the cabal install tar file.
export CABAL_INSTALL_URL=https://www.haskell.org/cabal/release/cabal-install-$CABAL_APP_VER/cabal-install-$CABAL_APP_VER.tar.gz

# download the tar file if necessary
if [[ ! -f $TMP_DIR/cabal-install-$CABAL_APP_VER.tar.gz ]]; then
  curl -L $CABAL_INSTALL_URL > $TMP_DIR/cabal-install-$CABAL_APP_VER.tar.gz
fi

# extract the tar file if necessary
if [[ ! -d $TMP_DIR/cabal-install-$CABAL_APP_VER ]]; then
  cd $TMP_DIR && tar -xvf cabal-install-$CABAL_APP_VER.tar.gz
fi

# build and install the application if necessary 
if [[ ! -f $CABAL_DIR/bin/cabal ]]; then
 cd $TMP_DIR/cabal-install-$CABAL_APP_VER && EXTRA_CONFIGURE_OPTS="" PREFIX=$HOME/.cabal ./bootstrap.sh
fi

# make sure cabal is in the current path
export PATH=$CABAL_DIR/bin:$PATH

# download package list if necessary
if [[ ! -f $CABAL_DIR/config ]]; then
  cabal update
fi

# backup the config file and set options
if [[ ! -f $CABAL_DIR/config.bak ]]; then
  cp $CABAL_DIR/config $CABAL_DIR/config.bak
  sed -i "/require-sandbox:/c\require-sandbox: True" $CABAL_DIR/config
fi


#---------------------------------------------------------------------
#
# CREATE THE ACTIVATE SCRIPT
#
#---------------------------------------------------------------------

if [[ ! -f $GHC_DIR/activate ]]; then
cat << EOF > $GHC_DIR/activate
#!/bin/sh

export PATH="$CABAL_DIR/bin:$GHC_DIR/bin:\$PATH"
EOF
fi

#---------------------------------------------------------------------
#
# PROVIDE SOME FEEDBACK
#
#---------------------------------------------------------------------
echo ""
echo "GHC $GHC_VER successfully installed."
echo "Cabal library $CABAL_LIB_VER successfully installed."
echo "Cabal application $CABAL_APP_VER successfully installed."
echo ""
echo "  To update your \$PATH for the current session use"
echo ""
echo "        source $GHC_DIR/activate"
echo ""
echo "  To set \$PATH for all future sessions add this to \$HOME/.bashrc"
echo ""
echo "        HASKELL_ENVIRONMENT_FILE=\"$GHC_DIR/activate\""
echo "        if [ -f \"\$HASKELL_ENVIRONMENT_FILE\" ]; then"
echo "          source \"\$HASKELL_ENVIRONMENT_FILE\""
echo "        fi"
echo ""
echo "enjoy!"
echo ""
exit
