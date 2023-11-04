# Pokémon Gold: Space World 1997 Demo Disassembly

This is a work-in-progress disassembly build of the Pokémon Gold prototype demoed at Space World 1997. This is my fork attempting to help further the disassembly progress as well as providing some guidance on how you may also assist in this important historical project.

At the very bottom of this README, you will find the original README provided on the PRET disassembly repository that this was initially forked from. Below you will also find the necessary tools for building or contributing to this project. 

## CONTRIBUTIONS EXTREMELY WELCOMED!
Please feel free to help with this as much as you want. I am doing this solo as of the time of writing this README and do not have a ton of experience working with ROMs at this level. Any and all help is immensely appreciated!

## Necessary Tools
- RGBDS: [**rgbds github**] and/or [**rgbds Install**]
- Programming Application Suggestions: [**Sublime Text Editor**] or [**Visual Studio Code**] (If you use VSCode, try out this syntax highlighter. It isn't perfect but it is still helpful. Please let me know if there is a better option that you recommend instead. [**VSCode Assembly Syntax Highlight**])
- A copy of Gold_debug.sgb renamed **baserom.gb** to build the ROMs (you will need to provide yourself)

[**rgbds github**]: https://github.com/gbdev/rgbds
[**rgbds Install**]: https://rgbds.gbdev.io/install
[**Sublime Text Editor**]: https://www.sublimetext.com/
[**Visual Studio Code**]: https://code.visualstudio.com/
[**VSCode Assembly Syntax Highlight**]: https://marketplace.visualstudio.com/items?itemName=Toeffe3.asm-syntaxhighlight

## macOS Mojave (10.14.6) Clean Setup Instructions
Please note, this is only tested with a clean install of macOS Mojave (10.14.6) on a 2018 MacBook Pro 15" with the following specs (CPU: 2.6 GHz Intel Core i7)(RAM: 16 GB 2400 MHz DDR4)(GPU: Intel UHD Graphics 630 1536 MB) (mores specs here [**Models**]) using an external SSD setup and may not be the same process for other macOS or Mac Hardware. This version was used as it is the most recent version of macOS that still supports 32-bit applications. This is helpful for tools like polished-map which will require Wine to be able to run them for map editing.

1) Download Xcode 11.3.1 from [**All Dev Downloads**]
2) Extract "Xcode_11.3.1.xip" to get the Xcode application
3) Move the Xcode application to your "Applications" folder
4) Run Xcode, read and agree to the terms of service, make sure it downloads all the necessary requirements
5) Install Homebrew following this tutorial [**Homebrew Install**] but ignore the first section about the Command Line Tools as this installs the wrong version and might not even be necessary since you already have Xcode installed and that should also automatically install the Command Line Tools that are needed
6) Install [**make**] as it is required by RGBDS
7) Install [**gcc**] as it is required by RGBDS
8) Install [**bison**] as it is required by RGBDS
9) Open a Terminal window and run the following command without the quotation marks: "cp /usr/local/opt/bison/bin/bison /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/bison"
10) Install [**pkg-config**] as it is required by RGBDS
11) Download and install [**Python 3**] so that you may compile everything properly
12) Download [**RGBDS 0.6.1**] for manual building
13) Extract "rgbds-0.6.1-macos-x86-64.zip" inside of your Downloads folder
14) In your Terminal window, CD to the root directory of the extracted folder
15) In your Terminal window, type "sh" (without the quotations) and then drag and drop the file named "install.sh" into your terminal window
16) Download and install [**Visual Studio Code**]
17) Download and install (insert text format reader name here later)
18) Install [**WineHQ**]
19) Download and install [**polished-map**] to run via WineHQ
20) In your Terminal window, CD to the root directory of the project
21) In your Terminal window, run the following command without the quotation marks: "gmake"
22) If you get an error stating "gmake: *** [Makefile:129: build/gfx/sgb/sgb_border.sgb.tilemap] Error 1", running the gmake command a second time seems to fix the issue

[**All Dev Downloads**]: https://developer.apple.com/download/all/
[**Homebrew Install**]: https://ralphjsmit.com/install-homebrew-macos
[**RGBDS 0.6.1**]: https://github.com/gbdev/rgbds/releases/v0.6.1#:~:text=rgbds%2D0.6.1%2Dmacos%2Dx86%2D64.zip
[**make**]: https://formulae.brew.sh/formula/make
[**gcc**]: https://formulae.brew.sh/formula/gcc#default
[**bison**]: https://formulae.brew.sh/formula/bison#default
[**pkg-config**]: https://formulae.brew.sh/formula/pkg-config
[**Python 3**]: https://www.python.org/downloads/
[**WineHQ**]: https://wiki.winehq.org/MacOS
[**polished-map**]: https://github.com/Rangi42/polished-map/releases
[**Models**]: https://support.apple.com/kb/SP776?viewlocale=en_US&locale=en_US

# Original PRET README for the repository

# Pokémon Gold and Silver: Space World 1997 Demo [![Build Status][ci-badge]][ci]

This is a work-in-progress disassembly of the Pokémon Gold and Pokémon Silver prototypes demoed at Space World 1997.

It builds the following ROMs:

- Gold_debug.sgb `sha1: b1d7539a87dea81b2cff6146afaad64470d08d84`
- Gold_debug.sgb (correct header) `sha1: 87fd8dbe5db39619529abcfc99e74cc5ecb8b94e`

You will need to provide a copy of Gold_debug.sgb renamed **baserom.gb** to build the ROMs.


### See also

- **Discord:** [pret][discord]
- **IRC:** [libera#pret][irc]

Other disassembly projects:

- [**Pokémon Red/Blue**][pokered]
- [**Pokémon Yellow**][pokeyellow]
- [**Pokémon Gold**][pokegold]
- [**Pokémon Crystal**][pokecrystal]
- [**Pokémon Pinball**][pokepinball]
- [**Pokémon TCG**][poketcg]
- [**Pokémon Ruby**][pokeruby]
- [**Pokémon FireRed**][pokefirered]
- [**Pokémon Emerald**][pokeemerald]

[pokered]: https://github.com/pret/pokered
[pokeyellow]: https://github.com/pret/pokeyellow
[pokegold]: https://github.com/pret/pokegold
[pokecrystal]: https://github.com/pret/pokecrystal
[pokepinball]: https://github.com/pret/pokepinball
[poketcg]: https://github.com/pret/poketcg
[pokeruby]: https://github.com/pret/pokeruby
[pokefirered]: https://github.com/pret/pokefirered
[pokeemerald]: https://github.com/pret/pokeemerald
[discord]: https://discord.gg/d5dubZ3
[irc]: https://web.libera.chat/?#pret
[ci]: https://github.com/pret/pokegold-spaceworld/actions
[ci-badge]: https://github.com/pret/pokegold-spaceworld/actions/workflows/main.yml/badge.svg
