Homebrew-VR
==============
These are Virtual Reality formulae for Homebrew. They include:
- [vr-jugglua patched for Mac](https://github.com/casallas/vr-jugglua)
  - [vr-juggler 3, CMake Version patched for Mac](https://github.com/casallas/vrjuggler-1)
    - [flagpoll](https://code.google.com/p/flagpoll/)
    - [gmtl](http://ggt.sourceforge.net/), [patched for Mac](https://gist.githubusercontent.com/anonymous/c16cad998a4903e6b3a8/raw/e4669b3df0e14996c7b7b53937dd6b6c2cbc7c04/gmtl_Sconstruct.diff)
  - [osg 2.8.6 patched for Mac](https://github.com/casallas/osg), this is the last osg version to include osgIntrospection, needed for osgLua, and thence vr-jugglua.

How do I install these formulae?
--------------------------------
Just `brew tap casallas/vr` and then `brew install <formula>`.

If the formula conflicts with one from Homebrew/homebrew/master or another tap, you can `brew install casallas/vr/<formula>`.

You can also install via URL:

```
brew install https://raw.github.com/casallas/homebrew-vr/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki][].

[wiki]:http://wiki.github.com/Homebrew/homebrew

What is Homebrew? I just want to install vr-jugglua
---------------------------------------------------

OK, just download and execute [this file](https://gist.githubusercontent.com/casallas/3903921/raw/vr-jugglua-install.sh).
It might take a while (I would say 2 hours) for it to compile and install all the dependencies, but it should work.

If you are curious, this script does the following:

```sh
#!/bin/bash

# Install homebrew (taken from http://brew.sh/)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add brew to your path
echo "# Prepend homebrew bins to your PATH" >> ~/.bash_profile
echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/local/Library/Contributions/examples:$PATH" >> ~/.bash_profile

# Tap casallas/vr
brew tap casallas/vr

# Update homebrew just in case
brew update

# Install vr-jugglua
brew install vr-jugglua

# Link NavTestbed.app to /Applications
ln -s `brew --prefix vr-jugglua`/NavTestbed.app /Applications
```

This will create a symlink of NavTestbed.app on your Applications folder, so you can run it from your dock.
The "real" NavTestbed.app, and all of vr-jugglua's examples, config files, etc, will be at 
`/usr/local/opt/vr-jugglua` in case you ever need them.

Troubleshooting
---------------

If something goes wrong try `brew update`, and then `brew install vr-jugglua` again. If that doesn't help run `brew install -v vr-jugglua`, open an issue, and paste the output from your console output.
