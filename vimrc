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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-Plug config
let g:plug_timeout=180

call plug#begin('~/.vim/plugged')
" YouCompleteMe - автодополнение кода
Plug 'Valloric/YouCompleteMe'

" TagBar - навигатор методов и классов
Plug 'majutsushi/tagbar'

" NerdTree - дерево проекта
Plug 'scrooloose/nerdtree'

" Color_coded - улучшенная подсветка кода
"Plug 'jeaye/color_coded'

" YCM-Generator - генератор конфига для плагина автодополнения
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Проверка кода python и подсветка
Plug 'python-mode/python-mode'

" Автозакрытие скобок
" Plug 'Townk/vim-autoclose'

" Java автодополнение
Plug 'artur-shaik/vim-javacomplete2'

" Пакет тем
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
  set foldmethod=syntax
  let g:java_highlight_all=1
  set term=screen-256color
  " Цветовая схема по-умолчанию
  colorscheme PaperColor
endif
set encoding=utf-8

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

if has("gui_running") 
  " размеры окна оконной версии vim
  set lines=24 columns=87
  " никаких панелей
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  colorscheme PaperColor
  " Подсветка текущей строки
  set cursorline
endif

" Vim > 7.0
if version >= 700
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000
  set undoreload=10000
endif 

" Нумерация строк
set number

" Русская раскладка
set keymap=russian-jcukenwin

" Английский по-умолчанию
set iminsert=0

" Отображение всех опций в статус линии
set wildmenu

" Правописание
set wcm=<C-Z>
menu SpellLang.RU_EN  :setlocal spell spelllang=ru,en <CR>
menu SpellLang.off    :setlocal nospell               <CR>
menu SpellLang.RU     :setlocal spell spelllang=ru    <CR>
menu SpellLang.EN     :setlocal spell spelllang=en    <CR>
map  :emenu SpellLang.

" Параметры печати
set printencoding=koi8-r
set printfont=terminus

" Подсветка курсора при отличной от английской раскладки
autocmd BufRead * highlight lCursor guifg=NONE guibg=Cyan

" Замена табуляции пробелами
set expandtab
set tabstop=2
set shiftwidth=2

" Строка состояния всегда видна
set statusline=%<%1*\ %t\ %y\ %0*%h%m%r\ \ %a\ %=0x%B\ line:%l,\ \ col:%c\ %P
set laststatus=2
" Подсветка имени и типа файла
"highlight User1 term=bold,italic ctermbg=LightCyan ctermfg=DarkGreen

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
"noremap <C-T> :TlistToggle<CR>
"let Tlist_GainFocus_On_ToggleOpen=1 " открыть и перейти
"let Tlist_Use_Right_Window=1 " открывать справа
"let Tlist_WinWidth=31 " ширина
"let Tlist_Inc_Winwidth=0 " размер окна неизменен
"let Tlist_Exit_OnlyWindow=1 " закрывать vim если TL единственное окно
"let Tlist_File_Fold_Auto_Close = 1 " файл закрыт - теги тоже

" TagBar открывать так
noremap <C-T> :TagbarToggle<CR>
"
" Дополнение команд
set showcmd

" NERDTree - открывалка
map <F10> :NERDTreeToggle<CR>
" Закрывать vim если NERDTree - единственное оставшееся окно
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" При открытие файлов .txt устанавливать следующие парамерты
autocmd BufRead *.txt set textwidth=80 
autocmd BufRead *.txt set autoindent 
autocmd BufRead *.txt set colorcolumn=+1

" Компилирование кода соответствующим компилятором
autocmd BufRead *.h,*.cpp map <F8> :! clear <CR> :cclose <CR> :make <CR> :cw <CR> <CR>
autocmd BufRead *.h,*.cpp map <F9> :! clear <CR> :make <CR>

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

" Переключение по табам
map <F7> :tabn <CR>
map <F6> :tabp <CR>

" Сохранение файлов
noremap  <silent> <F2>      :w<CR>
inoremap <silent> <F2> <Esc>:w<CR>
nnoremap <silent> <F2> <Esc>:w<CR>

noremap  <silent> <C-F2>      :wall<CR>
inoremap <silent> <C-F2> <Esc>:wall<CR>
nnoremap <silent> <C-F2> <Esc>:wall<CR>

" Запуск Makefile
noremap <F5> : make <CR> <CR>

" Размерность истории команд
set history=100

" Кодировка файлов
set fileencodings=utf-8,cp1251,ucs-bom,koi8-r,cp866,latin1

" Подсветка ограничения ввода кода с 80 строки
"if exists('+colorcolumn')
"  highlight ColorColumn ctermbg=235 guibg=#2c2d27
"  highlight CursorLine ctermbg=235 guibg=#2c2d27
"  highlight CursorColumn ctermbg=235 guibg=#2c2d27
"  let &colorcolumn=join(range(81,999),",")
"else
"  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"end

" Локаль
"lan ru_RU.utf-8
"lan mes ru_RU.utf-8
"lan tim ru_RU.utf-8
"lan cty ru_RU.utf-8

" Пример запуска программ в разных окнах при помощи tmux
"map <F8> :!clear && tmux send-keys -t .+ 'clear; ghci %' 'Enter' main <CR> <CR>
"map <F7> :!tmux send-keys -t .+ '' 'Enter' <CR> <CR>
"map <F6> :!tmux send-keys -t .+ ':q' 'Enter' <CR> <CR>

" JavaComplete2 config
autocmd FileType jsp setlocal omnifunc=javacomplete#Complete

" YouCompleteMe config
let g:ycm_server_python_path="/usr/bin/python3"
let g:ycm_python_binary_path="/usr/bin/python3"
"let g:ycm_global_ycm_extra_conf="/usr/local/share/vim/.ycm_extra_conf.py"
"let g:ycm_extra_conf_globlist = ['!~/*']

" синтаксические конструкции языка в идентификаторы
let g:ycm_seed_identifiers_with_syntax=1
" со скольки дополнять начинать
let g:ycm_min_num_of_chars_for_completion=3
" закрыть превью после окончания ввода
let g:ycm_autoclose_preview_window_after_insertion=1

" Высота выпадающего окна автокомпиляции
set pumheight=15
" колонка знаков(ошибка, предупреждение...) всегда видна
"set signcolumn=yes

" Сделать размер превью окна постоянным
set winfixheight
set previewheight=7

" Python-mode
" контроль качества кода
"let g:pymode_python = 'python3'
let g:pymode_lint=1
let g:pymode_lint_on_write=1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers=['pyflakes', 'pep8', 'mccabe']
" Подсветка кода и ошибок
let g:pymode_syntax=1
let g:pymode_syntax_all=1
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
" не сворачивать код автоматически
let g:pymode_folding=0
" Формат
let g:pymode_options_max_line_length = 80
let g:pymode_options_colorcolumn = +1
" Выпадающеее окно
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 7
" Точки остановки
let g:pymode_breakpoint = 0

