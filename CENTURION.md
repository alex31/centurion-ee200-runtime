# EE200 assembly runtime for Centurion CPU6

The `upstream` branch contains the original EE200 routines used here, imported
from Fuzix Compiler Kit commit `7b2a72edea6967e7df0b32e1e898fdea1754cc67`.
[Original EE200 source](https://github.com/EtchedPixels/Fuzix-Compiler-Kit/tree/7b2a72edea6967e7df0b32e1e898fdea1754cc67/supportee200)

The Centurion branch adapts stack cleanup and return-link preservation to the
CPU6 JSR/RSR behavior. It fixes operand order and arithmetic in helpers for
multiplication, division and remainder, comparisons, shifts and compound
assignment. The distribution assembles these sources with `asee200` to
build `libee200.a`.

The original README is retained for attribution. Its license section states
that the compiler's GPLv3 excludes the runtime. The selected EE200 sources
carry no separate license notice. Confirm redistribution terms with the
copyright holder before publishing this repository.
