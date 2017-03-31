This is a quick'n'dirty VIM-plugin which serves a very special purpose:
For a given hexadecimal number, it finds the next smaller number in a file.
I use it in a `map`-File from a compiler to find the current function given the current `PC`.

Nevertheless, it may be useful as-is, or just serve as a template for other similar functions.

`:[range]FindSmallerHex 0x1234`

This function will search for all hex-numbers, find the one which is smaller but closest to the parameter,
and set the last-search register `/` to that number. So you can use `n`, `p` so cycle multiple occurences.
