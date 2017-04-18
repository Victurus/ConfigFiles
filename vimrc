" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Vundle - сама система загрузки плагинов
Plugin 'VundleVim/Vundle.vim'

" YouCompleteMe - автодополнение кода
Plugin 'Valloric/YouCompleteMe'

" TagList - навигатор методов и классов
Plugin 'vim-scripts/taglist.vim'

" NerdTree - дерево проекта
Plugin 'scrooloose/nerdtree' 

" Color_coded - улучшенная подсветка кода
Plugin 'jeaye/color_coded' 

" YCM-Generator - генератор конфига для плагина автодополнения
Plugin 'rdnetto/YCM-Generator' 

" Проверка кода python и подсветка
Plugin 'Python-mode-klen'

call vundle#end()            
filetype plugin indent on    
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
  set foldmethod=syntax
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd       " Show (partial) command in status line.
"set showmatch     " Show matching brackets.
"set ignorecase    " Do case insensitive matching
"set smartcase     " Do smart case matching
"set incsearch     " Incremental search
"set autowrite     " Automatically save before commands like :next and :make
"set hidden        " Hide buffers when they are abandoned
"set mouse=a       " Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"let g:t_Co=8
"" For 256 color support
"function Color256_8()
"  if g:t_Co==256 
"    set t_Co=8
"    set t_Sf=<Esc>[3%p1%dm
"    set t_Sb=<Esc>[4%p1%dm
"  elseif t_Co == 8
"    set t_Co=256
"    set t_AB=<Esc>[48;5;%dm
"    set t_AF=<Esc>[38;5;%dm
"  endif
"endfunction

if has("gui_running") 
  " размеры окна оконной версии vim
  set lines=35 columns=99
  " никаких панелей
  set guioptions-=m
  set guioptions-=T
  colorscheme desert
  " Подсветка текущей строки
  set cursorline
endif

" Нумерация строк
set number

" Русская раскладка
set keymap=russian-jcukenwin

" Английский по-умолчанию
set iminsert=0

" Подсветка курсора при отличной от английской раскладки
highlight lCursor guifg=NONE guibg=Cyan

" Замена табуляции пробелами
set expandtab
set tabstop=2
set shiftwidth=2

" Строка состояния всегда видна
set statusline=%<%t%h%m%r\ \ %a\ %{strftime(\"%c\")}%=0x%B\ line:%l,\ \ col:%c%V\ %P
set laststatus=2

" Перенос слов целиком
set linebreak

" Показывать первую парную скобку после ввода второй
set showmatch

" Разбивать окно горизонтально снизу
set splitbelow

" Разбивать окно горизонтально сверху
set splitright

" Настройка представления непечатных символов командой
set listchars=tab:>-,space:·,eol:¬

" Чтобы легче Tag-list открывался (TlistToggle)
map <F12> :TlistToggle<CR>

" Отображение всех опция в статус линии
set wildmenu

" Дополнение команд
set showcmd

" NERDTree - открывалка
map <F10> :NERDTreeToggle<CR>
" Закрывать vim если NERDTree - единственное оставшееся окно
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Компилирование кода соответствующим компилятором
autocmd BufRead *.h,*.cpp map <F8> :! clear <CR> :cclose <CR> :make <CR> :cw <CR> <CR>
autocmd BufRead *.h,*.cpp map <F9> :! clear <CR> :make <CR>

autocmd BufRead *.h,*.cpp map <F6> :! clear; g++ --std=c++11 -o0 -g % -o %<; ./%< <CR>
autocmd BufRead *.h,*.cpp map <F7> :! clear; g++ --std=c++11 -o0 -g % -o %< <CR>

"autocmd BufRead *.h,*.cpp map <F6> :! clear; g++ --std=c++11 -o0 -g % -o %<; tmux send-keys -t .+ ' clear; ./%<' Enter <CR> <CR>
"autocmd BufRead *.h,*.cpp map <F7> :! clear; g++ --std=c++11 -o0 -g % -o %< <CR>

autocmd BufRead *.lsp map <F8> :! clear <CR> :!socat readline exec:"sbcl --noinform --load % --eval '(exit)'" <CR>

autocmd BufRead *.lua map <F8> :! clear <CR> :! lua % <CR>

autocmd BufRead *.tex map <F8> :! clear <CR> :! pdflatex % <CR>

autocmd BufRead *.rb  map <F8> :! clear <CR> :! ruby % <CR>

autocmd BufRead *.py  map <F8> :! clear <CR> :! python3 % <CR>

" Переключение по буферам кнопками
map  <F4>      :bn <CR>
imap <F4> <Esc>:bn <CR>i
vmap <F4> <Esc>:bn <CR>

map  <F3>      :bp <CR>
imap <F3> <Esc>:bp <CR>i
vmap <F3> <Esc>:bp <CR>

" Сохранение файлов
noremap  <F2>      :wall<CR>
inoremap <F2> <Esc>:wall<CR>
nnoremap <F2> <Esc>:wall<CR>
vnoremap <F2>      :y+ <CR>

" Запуск Makefile
map <F5> : make <CR> <CR>

" Размерность истории команд
set history=100

" Кодировка файлов
set fileencodings=utf-8,cp1251,ucs-bom,koi8-r,cp866,latin1

" Цвет колонки - синий
highlight ColorColumn ctermbg=blue

" Локаль
"lan ru_RU.utf-8
"lan mes ru_RU.utf-8
"lan tim ru_RU.utf-8
"lan cty ru_RU.utf-8

" Пример запуска программ в разных окнах при помощи tmux
"map <F8> :!clear && tmux send-keys -t .+ 'clear; ghci %' Enter main <CR> <CR>
"map <F7> :!tmux send-keys -t .+ '' Enter <CR> <CR>
"map <F6> :!tmux send-keys -t .+ ':q' Enter <CR> <CR>

" Python-mode
" контроль качества кода
let g:pymode_lint=1
let g:pymode_lint_checkers=["pyflakes3"]
" Подсветка кода и ошибок
let g:pymode_syntax=1
let g:pymode_syntax_all=1
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
" не сворачивать код автоматически
let g:pymode_folding=0
