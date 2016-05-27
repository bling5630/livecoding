#!/bin/bash

#
# installs commonly used binaries
#

cabal-install alex
cabal-install hasktags
cabal-install happy

cabal-install hoogle
hoogle data all

cabal-install ghc-mod
cabal-install wia-app-static

cabal-install http://ghcjs.luite.com/master.tar.gz
ghcjs-boot
