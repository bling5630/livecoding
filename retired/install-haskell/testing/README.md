# Testing

The basic idea is that all of the guides will have automated testing if at all possible.


# Linux Testing

Use Docker it's fastestest.

Build an image for each distro being tested.  It will just be the base image with a new user that has sudo permissions.  Also install the guides script in that users directory.

Have a test script that runs the image to make sure ghc/cabal are installed and working as expected.


# others? FreeBSD, Windows and OSX

use some kind of vurtualization to create an image that can be snapshot and rolled back between tests
