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

The packaged versions include GHC 7.

Add backports to your apt sources if you haven't already:

```
echo 'deb http://ftp.debian.org/debian/ jessie-backports main' | sudo tee /etc/apt/sources.list.d/bp.list
sudo apt-get update
```

Then install GHC and Cabal:

```
sudo apt-get update && apt-get -t jessie-backports install ghc cabal-install
cabal update && echo export PATH='$HOME/.cabal/bin:$PATH' >> $HOME/.bashrc
```
