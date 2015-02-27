" Vim syntax file
" Language: nix
" Maintainer: Marc Weber <marco-oweber@gmx.de>
"               Modify and commit if you feel that way
" Last Change:  2011 Jun
"
" this syntax file can be still be enhanced very much..
" Don't ask, do it :-)
" This file (github.com/MarcWeber/vim-addon-nix) is periodically synced with
" the patch found in vim_configurable (nixpkgs)

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif


sy cluster nixStrings contains=nixStringParam,nixStringIndented

syn keyword nixKeyword  let throw inherit import true false null with
syn keyword nixConditional  if else then
syn keyword     nixBrace        ( ) { } =
syn keyword     nixBuiltin         __currentSystem __currentTime __isFunction __getEnv __trace __toPath __pathExists 
  \ __readFile __toXML __toFile __filterSource __attrNames __getAttr __hasAttr __isAttrs __listToAttrs __isList 
  \ __head __tail __add __sub __lessThan __substring __stringLength

syn region nixStringIndented start=+''+ skip=+'''\|''${\|"+ end=+''+ contains=nixStringParam
" syn region nixString         start=+"+ skip=+\\"+ end=+"+
syn region nixString         start=+"+ skip=+\\"+ end=+"+ contains=nixStringParam
syn match nixAttr "\w\+\ze\s*="
syn match nixFuncArg "\zs\w\+\ze\s*:"
syn region nixStringParam start=+\${+ end=+}+ contains=@nixStrings
syn region nixMultiLineComment start=+/\*+ skip=+\\"+ end=+\*/+
syn match  nixEndOfLineComment "#.*$"

hi def link nixKeyword       Keyword
hi def link nixConditional   Conditional
hi def link nixBrace         Special
hi def link nixString        String
hi def link nixStringIndented String
hi def link nixBuiltin       Special
hi def link nixStringParam   Macro
hi def link nixMultiLineComment Comment
hi def link nixEndOfLineComment Comment
hi def link nixAttr        Identifier
hi def link nixFuncArg     Identifier

syn sync maxlines=20000
syn sync minlines=50000

let b:current_syntax = "nix"

" thanks to iElectric
" scan backwards to find begining of multiline statements
syn sync ccomment nixMultiLineComment minlines=10 maxlines=500
syn sync ccomment nixStringIndented minlines=10 maxlines=500
syn sync ccomment nixString maxlines=10
