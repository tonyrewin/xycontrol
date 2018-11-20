XYControl
===========

XY midi-controller app with zero config.  

Implementation Notes
--------------------
Applies a reusable XY view control, immediately giving  wireless midi signals for any DAW.

Differences from XYAudioView: 

- does not use any xib/nib/storyboards
- does not use audio engine
- uses CoreMIDI

Install
-------

For now it is possible to install it to the connected iOS-device with compiling in XCode. It requires a developer certificate.

Setup
-----

iOS does not requere any setup. However, if you don't know how to use MIDI over WiFi in OSX, there is a guide with landmarks:

1. Install and launch an app
2. Launch Settings -> Utilities -> Audio MIDI Setup
3. Pick another window at the menu: Window -> Show MIDI Studio
4. Open MIDI Network Setup... (Configure Network Driver)
5. See your app running device at the list? Pick it and press "Connect" button.
6. Done! Touchscreen manipulations should be seen as MIDI signals in your DAW. Good luck!

NOTE: It sends both params at the same time, but flipping an order. So you can bind it in your DAW. Simply tap once to learn the first MIDI CC link and then tap again to learn another parameter signature.

Contributions
------------

are welcome.

Authors
------
Tony Rewin
Gary Newby

License
-------
Licensed under the MIT License.
