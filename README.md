# HCPL — Human-Centred Programming Language

"Humans write naturally. The engine understands precisely."

HCPL is an English-like scripting language. Its runtime is built on
[Lua](https://www.lua.org) 5.5.1 by Lua.org, PUC-Rio: the virtual machine,
garbage collector and standard library are Lua's, and the front end
(lexer and parser) is being rewritten to read `.hpl` source.

The `init` commit is unmodified Lua 5.5.1, so diffing against it shows
exactly what HCPL changes.

Design notes and the v0.1 spec live in the earlier repo:
https://github.com/AstricX9/Human-Centred-Programming-Language

## Build

    make linux        # or: make macosx, make mingw

## License

MIT. See [LICENSE](LICENSE). HCPL is not affiliated with or endorsed by
Lua.org or PUC-Rio.
