# A Comprehensive Guide To Installing Haskell

There are a few ways to install Haskell depending on your goals.

  1. [Stack](#stack)
  2. [Binaries](#binaries)
  3. [Source](#source)

### Stack

In most situations, for most people, [Stack](https://docs.haskellstack.org/en/stable/README/) is the best installation choice.  Stack is a Haskell build tool.  It's able to manage multiple versions of Haskell packages and GHC on a per project or global basis.  It does require learning the Stack workflow but that burden is quite low given the advantages it provides.

### Binaries

There are precompiled binary packages available for most operating systems.  These often lag behind the current version available from source.  This installation method is most appropriate if your operating system isn't supported by Stack or you're an experienced user who prefers Cabal sandboxes to Stack.  It's also worth mentioning that once the [new build](http://ezyang.com/nix-local-build.html) system matures this may become a much more attractive choice.

  * [Debian Jessie](#binary-debian-jessie)

### Source

Building from source is appropriate when there's no precompiled packages available for your operating system or the versions available are out of date.

## Instructions

Operating system specific installation instructions

  * [Windows](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/WINDOWS.md)
  * [OSX](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/OSX.md)
  * [Arch](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/ARCH.md)
  * [Debian](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/DEBIAN.md)
  * [Fedora](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/FEDORA.md)
  * [FreeBSD](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/FREEBSD.md)
  * [NixOS](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/NIXOS.md)
  * [Ubuntu](https://github.com/mgreenly/livecoding/blob/master/install-haskell/guides/UBUNTU.md)

