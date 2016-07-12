# kvm-mouse-switcher
Sends KVM switching keystroke on certain mouse gesture. Windows only.

## Description
KVM switches allow to jump from one PC to another with the use of some key sequence. As of DLink KVM-221 these sequences are double CapsLock or double ScrollLock. Often it's more convenient to use mouse gesture to switch. This script recognizes double knocking the screen edge (left or right) and issues switching keystroke in respond.

## Implementation notes
The script is written in [AutoIt v3](https://www.autoitscript.com/site/autoit/) language, [WSH](https://technet.microsoft.com/en-us/library/ee156603.aspx) is used to send a keystroke to keyboard buffer. Latest compiled executable is also provided, so there is no need to install AutoIt unless you need to change/recompile the script.

## Launching
Just run `left-to-right.bat` or `right-to-left.bat` to respond to right and left screen edge, respectively.

## Limitations
Compiled script is just a console application, so mouse-driven switching does not work when PC is locked.
