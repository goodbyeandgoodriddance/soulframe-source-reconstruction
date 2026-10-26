# Soulframe reconstructed source tree

Build pin: `2026.10.08.15.20 Retail Windows x64 [Stripped]`

This directory mirrors the game's original resource filesystem (paths as
they appear in `Cache.Windows` TOC records). Each file is a `.lua`
because the game ships Luau identifier files with that extension.

## Contents

- 975 recovered Luau source files (full source, atoms named via v4 catalog, all syntax-compile)
- 2 bytecode-disassembly fallback pairs for scripts the source-form decompiler cannot structure:
  - `SF/Interface/Settings.lua` + `SF/Interface/Settings.lua.bytecode`  (failing prototypes: [666, 686])
  - `SF/Scripts/Prototypes/NightfoldVendorStation.lua` + `SF/Scripts/Prototypes/NightfoldVendorStation.lua.bytecode`  (failing prototypes: [3])

`INDEX.json` lists every entry with its path, kind, byte count, and
content SHA-256. Resource paths were validated against directory
traversal before placement.
