# Space World 1997 Gold Disassembly

WIP disassembly of the Space World 1997 Gold proto

It attempts to build the following ROMs:

```
pokegold_spaceworld.gb         (MD5: 3c407114de28d17b7113a2c0cee9a37c)  
pokegold_debug_spaceworld.gb   (MD5: 2eadbed83b775c097ff79e5128d1184f)  
pokesilver_spaceworld.gb       (MD5: c52a677c35f15320d5b495e14809f00d)  
pokesilver_debug_spaceworld.gb (MD5: fa65d3759bb17c489de171a598ba4913)  
```

## Installation

Requires [RGBDS](https://github.com/rednex/rgbds) version 0.3.8 or newer to build!

### Base ROM 

You will need to obtain the ROM, ensure the MD5 matches with the above checksums and rename the file to `baserom.gb`

### MacOS Notes

For MacOS users, there are a few extra steps required to build the source. 

#### gmake
The `make` package that comes with MacOS is incompatible. Install the GNU Make from [brew](https://brew.sh/): 
```
brew install homebrew/core/make
```

#### md5sum 
An alias needs creating, in your terminal enter in the following command:

```
alias md5sum='md5 -r'
```

## Building
From the base directory:

```
make
```

Or for MacOS users:

```
gmake
```

## See also
* Discord: [**pret**][Discord]

[Discord]: https://discord.gg/vdTW48Q
