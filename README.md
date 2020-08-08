# Pokémon Gold and Silver: Space World 1997 Demo [![Build Status][travis-badge]][travis]

This is a work-in-progress disassembly of the Pokémon Gold and Pokémon Silver prototypes demoed at Space World 1997.

It builds the following ROMs:

- Gold_debug.sgb `md5: 2eadbed83b775c097ff79e5128d1184f`
- Gold_debug.sgb (correct header) `md5: 8e509301f6db1f89fee85aead8ebf8d4`

You will need to provide a copy of Gold_debug.sgb renamed **baserom.gb** to build the ROMs.

You will also need **rgbds 0.3.8**. If that is not your default version, you can put the 0.3.8 files in a subdirectory like rgbds/ and run `make RGBDS=rgbds/` instead of `make`.


## See also

- **Discord:** [pret][discord]
- **IRC:** [freenode#pret][irc]

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
[irc]: https://kiwiirc.com/client/irc.freenode.net/?#pret
[travis]: https://travis-ci.org/pret/pokegold-spaceworld
[travis-badge]: https://travis-ci.org/pret/pokegold-spaceworld.svg?branch=master
