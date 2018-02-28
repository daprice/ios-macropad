# The Missing Macropad
A tiny (3x4 key) bluetooth keypad using low profile mechanical keyboard switches and the Adafruit Feather 32u4 Bluefruit, intended to give you quick access to functions on your iOS device that are normally cumbersome to use. Or a companion to a 60% or smaller keyboard. Your choice.

## PCB
Find the [KiCad](http://kicad-pcb.org) source files in the PCB folder.

### Switches
This PCB uses mechanical keyswitches compatible with Kailh PG1350, commonly known as "Choc" Low Profile. These are available in various varieties and in small quantities from vendors like [NovelKeys](https://novelkeys.xyz) in the US.

### Gerber and drill files
The files in `PCB/gerbers` were produced by KiCad 4.0.7 using [OSH Park's recommended settings](https://docs.oshpark.com/design-tools/kicad/generating-kicad-gerbers/). If you have the PCB manufactured somewhere else, you may change the names of the files at the very least (your board house should provide their desired filenames and any special settings they require).

## Acrylic case
The case is currently a work in progress; further documentation will be provided when it's complete.

## Firmware
Firmware will be based on [QMK](http://qmk.fm).


------------------------

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).