Homebrew-VR
==============
These are Virtual Reality formulae for Homebrew. They include vr-juggler, vr-jugglua,
an older version of osg (osg28, needed for vr-jugglua), an older version of boost (1.49, needed for cppdom) and
an alternative version of cppdom (that requires boost 1.49 specifically).

How do I install these formulae?
--------------------------------
Just `brew tap jscasallas/vr` and then `brew install <formula>`.

If the formula conflicts with one from mxcl/master or another tap, you can `brew install jscasallas/vr/<formula>`.

You can also install via URL:

```
brew install https://raw.github.com/jscasallas/homebrew-vr/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki][].

[wiki]:http://wiki.github.com/mxcl/homebrew

What is Homebrew? I just want to install vr-jugglua
---------------------------------------------------

OK, just download and execute [this file](https://raw.github.com/gist/3903921/4c40c1d32643fa61ad79619f25378ae101ebcef2/vr-jugglua-install.sh).
It might take a while (I would say 2 hours) for it to compile and install all the dependencies, but it should work.

If you are curious, this script does the following:

```sh
#!/bin/bash

# Install homebrew
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# Tap jscasallas/vr
brew tap jscasallas/vr

# Install vr-jugglua
brew install vr-jugglua

# Link NavTestbed.app to /Applications
ln -s `brew --prefix vr-jugglua`/NavTestbed.app
```
