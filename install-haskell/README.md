# A Comprehensive Guide To Installing Haskell

There are a few ways to install Haskell depending on your goals.

  1. [Stack](#stack)
  2. [Binary Packages](#binary-packages)
  3. [Source](#from-source)

## Stack

In most situations [Stack](https://docs.haskellstack.org/en/stable/README/) is currently the best choice for the most people.  Stack is a Haskell build tool.  It's able to manage multiple versions of Haskell packages and GHC on a per project or global basis.  It does require learning the Stack workflow but that burden is quite low given the advantages it provides.  Stack by default uses a fairly complete currated list of recent packages known to work together along with a modern version of GHC but does allow you to override these chocies if necessary.

## Binary Packages

There are precompiled binary packages available for most operating systems.  These often lag behind the current relese available from source.  This installation method is most appropriate if you're trying to following along with a tutorial or book that pre-dates Stack and don't want to learn stack or you're an experienced user who prefers Cabal sandboxes to Stack.  It's also worth mentioning that once the new [nix style build](http://ezyang.com/nix-local-build.html) system matures this may become a much more attractive choice.

  * [Debian Jessie](#debian-jessie)

## From Source

Building from source is appropriate when there's no precompiled packages available for your operating system or the versions available are out of date.


### Debian Jessie

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
