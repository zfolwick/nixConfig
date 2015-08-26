
"Use Pathogen for modules
execute pathogen#infect()

"basic settings
set number
set nocp
set ls=2
set ts=4
set ruler
set ignorecase
set modeline
set autoindent
set nobackup
set wrap
set hidden
syntax on
set mouse=a
filetype plugin indent on
set shiftwidth=4
set expandtab


"colors
color desert

"remap jj to be an escape character
imap jj <esc>

" set nice paste mode
set pastetoggle=<f11>

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" Add closing braces
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}


setf cpp

"Pester abbreviations
"  It statement doesn't include closing braces because those are already
"  auto-added by above code
iabbrev <buffer> It" It "" { <CR><CR><Esc><Up>

" Various convenient abbreviations of commonly used pester 'phrases'
iabbrev <buffer> snt Should Not Throw
iabbrev <buffer> st Should Throw

" silly, eye-catching debug message for quick debugging
iabbrev <buffer> dmg Console.WriteLine("DERPDERP");

