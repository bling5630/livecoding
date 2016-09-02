# A Comprehensive Guide To Installing Haskell

There are a few ways to install Haskell depending on your goals.

  1. [Stack](#stack)
  2. [Binary Packages](#binary-packages)
  3. [Source](#from-source)

### Stack

In most situations, for most people, [Stack](https://docs.haskellstack.org/en/stable/README/) is the best installation choice.  Stack is a Haskell build tool.  It's able to manage multiple versions of Haskell packages and GHC on a per project or global basis.  It does require learning the Stack workflow but that burden is quite low given the advantages it provides.  #

### Binary Packages

There are precompiled binary packages available for most operating systems.  These often lag behind the current version available from source.  This installation method is most appropriate if your operating system isn't supported by Stack or you're an experienced user who prefers Cabal sandboxes to Stack.  It's also worth mentioning that once the new [nix style build](http://ezyang.com/nix-local-build.html) system matures this may become a much more attractive choice.

  * [Debian Jessie](#binary-debian-jessie)

### From Source

Building from source is appropriate when there's no precompiled packages available for your operating system or the versions available are out of date.

  * [Debian Jessie](#source-debian-jessie)


## OS Specific Instructions

  * [Windows](#)
  * [OSX](#)
  * [Arch](#)
  * [Debian](https://github.com/mgreenly/livecoding/blob/master/install-haskell/DEBIAN.MD)
  * [Fedora](#)
  * [FreeBSD](#)
  * [NixOS](#)
  * [Ubuntu](#)


