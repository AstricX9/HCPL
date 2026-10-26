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

## Build and test

    make linux        # or: make macosx, make mingw
    make test         # runs tests/language.hpl
    src/lua examples/hello.hpl

On Windows without make, run this (it uses gcc, or Visual Studio if gcc is missing):

    .\build.bat
    .\hcpl.exe examples\guess.hpl

## What works today

```hpl
include math;

function clamp(value and min and max) {
    if value is less than min {
        return min;
    }
    else if value is greater than max {
        return max;
    }
    return value;
}

program Main {
    start {
        let hp be 100;
        increase hp by 20;
        set hp to clamp(hp and 0 and 110);
        print "HP is " + hp;          // HP is 110
    }
}
```

- `let x be 10;` declares a local, `set x to 5;` assigns (and creates a
  global on first use).
- `function f(a and b) { }`, called as `f(1 and 2)`. Commas also work.
  Inside call parentheses `and` separates arguments; write `f((a and b))`
  for a logical and.
- Comparisons: `is equal to`, `is not equal to`, `is greater than`,
  `is less than`, each with `or equal to` where it makes sense. Lua's
  `==`, `<` and friends still work.
- No operator precedence: `10 + 5 * 2` is 30.
- `+` with text joins it: `"Sum is " + 30`.
- `increase`, `reduce`, `multiply`, `divide` ... `by` (on plain names).
- `yes` / `no`, durations `30s`, `2m`, `1h` (numbers of seconds).
- `task Name { }` is a function with no parameters.
- `program Name { start { } }` runs `start` after the program's other
  declarations.
- `include name;` loads a module (`name = require "name"`).
- `//` and `/* */` comments. Blocks use braces; Lua's `while` and `for`
  loops work with braces.

Not yet: components and events (`button ... { on press { } }`), and the
old repo's native `math.add` / `system.io` modules.

## License

MIT. See [LICENSE](LICENSE). HCPL is not affiliated with or endorsed by
Lua.org or PUC-Rio.
