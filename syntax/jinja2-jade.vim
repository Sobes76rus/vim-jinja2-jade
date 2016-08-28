if exists("b:current_syntax")
    finish
endif

runtime! syntax/jinja.vim
unlet b:current_syntax

syn case match

"syn region megablock start="^" end="$"
"syn match block /.*/ contained
"hi link block Debug
"hi link megablock Comment

" ****   JADE   ****
" Block
syn region  j2jBlock start=/^\z(\s*\)/ end=/^\%(\z1\s\|\s*$\)\@!/

" Comment
syn region  j2jJadeComment start=/^\z(\s*\)\/\// end=/^\%(\z1\s\|\s*$\)\@!/ containedin=j2jBlock

" Tag block
syn region  j2jJadeTagBlock start=/\S/ end=/\s\|!\?[=-]\|$/me=s-1 containedin=j2jBlock nextgroup=j2jJadeText
"nextgroup=j2jJadeText,jinjaVarBlock,jinjaTagBlock
syn match   j2jJadeTagBlockDelim /:\s\+/ containedin=j2jJadeTagBlock nextgroup=j2jJadeClassDelim,j2jJadeIdDelim,j2jJadeTag

" Tag
syn match   j2jJadeClassDelim   /\./    containedin=j2jJadeTagBlock nextgroup=j2jJadeClass
syn match   j2jJadeIdDelim      /#/     containedin=j2jJadeTagBLock nextgroup=j2jJadeId
syn match   j2jJadeTextDelim    /|/     containedin=j2jJadeTagBlock nextgroup=j2jJadeText

syn match   j2jJadeTag      /\w\+/          containedin=j2jJadeTagBlock nextgroup=j2jJadeAttrs
syn match   j2jJadeClass    /\%(\w\|-\)\+/  contained nextgroup=j2jJadeAttrs
syn match   j2jJadeId       /\%(\w\|-\)\+/  contained nextgroup=j2jJadeAttrs
syn match   j2jJadeText     /\s.*$/         contained

syn cluster j2jJadeTextGroup contains=j2jJadeText

" Attrs
syn region  j2jJadeAttrs start=/(/  end=/)/  containedin=j2jJadeTagBlock
syn match   j2jJadeAttr /\w\|[-]/ containedin=j2jJadeAttrs nextgroup=jinjaVarBlock

hi link j2jJadeAttrs Normal
hi link j2jJadeAttr PreProc


" Jinja2
syn region  jinjaTagBlock matchgroup=jinjaTagDelim start=/!\?-/ end=/$/ containedin=j2jBlock
syn region  jinjaVarBlock matchgroup=jinjaVarDelim start=/!\?=/ end=/$/ containedin=j2jBlock

syn region  jinjaTagBlock matchgroup=jinjaTagDelim start=/!\?-/ end=/\s\|[,)]/me=s-1 containedin=j2jAttrs
syn region  jinjaVarBlock matchgroup=jinjaVarDelim start=/!\?=/ end=/\s\|[,)]/me=s-1 containedin=j2jAttrs

hi link j2jBlock                Statement
hi link j2jJadeTagBlock         Error
hi link j2jJadeComment          Comment

hi link j2jJadeTag              Function
hi link j2jJadeClass            Type
hi link j2jJadeId               Identifier
hi link j2jJadeText             String

hi link j2jJadeClassDelim       Special
hi link j2jJadeIdDelim          Special
hi link j2jJadeTextDelim        Special
hi link j2jJadeTagBlockDelim    Special

hi link jinjaTagDelim           Special
hi link jinjaVarDelim           Special

let b:current_syntax="jinja2-jade"
