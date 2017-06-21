Toolchain Setup for Building an Interactive 2D Graphics Demo
============================================================

This is a meta-project for audience participation in the session called
[“How to Build a Portable, Eco-Friendly, Interactive 2D Graphics Demo out of Spare Parts”][session]
at [Open Source Bridge 2017][osb2017].

[session]:  <http://opensourcebridge.org/sessions/2077>
[osb2017]:  <http://opensourcebridge.org/y2017/>

Following the formal portion of the talk, you're invited to create your own demo,
using the same abstractions for graphics and user input demonstrated in the talk.

Mac OS X / OS X / macOS
-----------------------

Mac OS X 10.6 “Snow Leopard” or later is required
(for interprocess mutex/condvar support).

You must have the command-line developer tools installed.
It's not necessary to have Xcode.

Make sure you're connected to the Internet, and run (from this directory)

	make gradient

This does everything described in each of the sections below:

* clones the monolithic [metamage_1][] repository.
This contains the build tools and most of the code.
* clones the [freemount][] repository.
Freemount is the protocol used between `MacRelix.app` and its clients,
and the protocol libraries and the `interact` tool are stored here.
* clones the [macward-compat][] repository.
This contains the “missing-macos” project,
which is necessary to build `MacRelix.app` on Mac OS X 10.7 “Lion” and later.

[metamage_1]:       <https://github.com/jjuran/metamage_1>
[freemount]:        <https://github.com/jjuran/freemount>
[macward-compat]:   <https://github.com/jjuran/macward-compat>

(You can also accomplish just this part by running `make clone`.)

* builds the `display` tool, for displaying graphics in a window.
* builds the `interact` tool, for displaying graphics in a window and capturing user input.
* builds the `telecast-send` tool, for transmitting graphics to a remote display.
* builds the `skif` tool, a multi-purpose utility which is used to manage SKIF files.
* builds the `nyancat` exhibit, which is a sample SKIF author program. 🌈 🐱 🎆
* builds the `exhibit` tool, which manages the interaction of all the above.
* builds the `uunix` connector module, which `interact` uses to connect over Unix-domain sockets.
* builds the `A-line` build tool, which can build Mac applications.
* builds the `cpres` tool, for copying resources.
* builds the `vx` interpreter for the [V language][V], used to generate `Info.plist`.
* builds `MacRelix.app`, which is a display server on Mac OS X.

[V]:  <https://www.vcode.org/>

* launches MacRelix.
* creates a new SKIF file and writes a 512x384 gradient into it.
* runs `exhibit` to display it.  (Close the window when you're done.)

Now try an interactive demo:

	make nyancat

Controls:

* Space, click: play/pause
* Left/Right arrows: frame step
* Up/Down arrows: adjust frame rate
* Shift- or Option-arrow: adjust the head's position
* `0`: restore original graphics
* `q`: quit

Thanks for watching!
