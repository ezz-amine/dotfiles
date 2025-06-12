let g:currentmode={
     \ 'n'  : 'NORMAL',
     \ 'v'  : 'VISUAL',
     \ 'V'  : 'V·LINE',
     \ '' : 'V·BLOCK',
     \ 's'  : 'SELECT',
     \ 'S'  : 'S·LINE',
     \ 'i'  : 'INSERT',
     \ 'R'  : 'REPLACE',
     \ 'Rv' : 'V·REPLACE',
     \ 'c'  : 'COMMAND',
 \}

 " Enable relative line numbers
 set relativenumber

 " Show absolute line number for current line
 set number

 " Set leader key to <Space>
 let mapleader = " "

 " Hide ~ at empty lines
 set fillchars=eob:\ 

 " Always show status line
 set laststatus=2

 " Custom status line
 set statusline=
 set statusline+=%#PmenuSel#              " Color highlight
 set statusline+=\ %{g:currentmode[mode()]}\             " Current mode (NORMAL/I    NSERT/VISUAL)
 set statusline+=%#LineNr#                " Switch color
 set statusline+=\ %f                     " File path
 set statusline+=\ %y                     " File type
 set statusline+=\ %l/%L                  " Current line / Total lines
 set statusline+=\ [%{&fileformat}]       " File format (DOS/Unix/Mac)
 set statusline+=\ %=%{&fileencoding}     " File encoding (right-aligned)

