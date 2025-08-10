" Circuit Macros Syntax Highlighting
if exists("b:current_syntax")
  finish
endif
syn match m4Comment "dnl.*$"

syn region m4BacktickString start="`" end="'" skip="\\'"
syn region m4DoubleQuoteString start=+"+ end=+"+ skip=+\\"+
syn match m4Number "\<\d\+\>"

" Circuit Macro specific highlights
syn match m4Component "\(arrow\|capacitor\|inductor\|diode\|transistor\)\>" 
syn match m4Connection "\(up\|down\|left\|right\|from\|to\|at\)\>"
syn match m4SpecialMacro "\(And\|Or\|Xor\|Not\|Nand\|Nor\|DFF\)\>"
syn match m4Pin "\(in\|out\|vcc\|gnd\)\>"

" Drawing commands
syn match m4DrawCommand "\(line\|arc\|spline\|dot\|arrow\)\>"
syn match m4Attribute "\(color\|dashed\|thick\|fill\)\>"

" Highlight groups
hi def link m4Comment Comment
hi def link Sm4String String
hi def link m4DoubleQuoteString  String


hi def link m4Number Number
hi def link m4Component Type
hi def link m4Connection Identifier
hi def link m4SpecialMacro Function
hi def link m4Pin Constant
hi def link m4DrawCommand Statement
hi def link m4Attribute PreProc

let b:current_syntax = "c"
