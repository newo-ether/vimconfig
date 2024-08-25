set modelines=0                          " 禁用模式行（安全措施）
syntax on                                " 语法高亮
filetype on                              " 开启文件类型检测
colorscheme codedark

set encoding=utf-8                       " 编码设置
set number                               " 显示行号
set smartindent                          " 智能缩进
set autoindent                           " 自动对齐

set smarttab
set tabstop=4                            " tab缩进
set shiftwidth=4                         " 设定自动缩进为4个字符
set expandtab                            " 用space替代tab的输入
set splitright                           " 设置左右分割窗口时，新窗口出现在右侧
set splitbelow                           " 设置水平分割窗口时，新窗口出现在底部
set hidden

set nobackup                             " 不需要备份
set noswapfile                           " 禁止生成临时文件
set autoread                             " 文件自动检测外部更改
set clipboard=unnamed                    " 共享剪切板

set nocompatible                         " 去除vi一致性
set ambiwidth=double                     " 解决中文标点显示的问题
set mouse=a                              " 使用鼠标
set mousehide                            " 输入时隐藏光标
set sidescroll=10                        " 移动到看不见的字符时，自动向右滚动是个字符
set scrolloff=1

set sm!                                  " 高亮显示匹配括号
set hlsearch                             " 高亮查找匹配
set cursorline                           " 高亮显示当前行

set showmatch                            " 显示匹配
set ruler                                " 显示标尺，在右下角显示光标位置
set novisualbell                         " 不要闪烁
set showcmd                              " 显示输入的命令

" 设置netrw-------------------------------------
let g:netrw_banner = 0         " 设置是否显示横幅
let g:netrw_liststyle = 3      " 设置目录列表样式：树形
let g:netrw_browse_split = 4   " 在之前的窗口编辑文件
let g:netrw_altv = 1           " 水平分割时，文件浏览器始终显示在左边
let g:netrw_winsize = 20       " 设置文件浏览器窗口宽度为20%

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :Lexplore
augroup END

let g:apc_enable_ft = {'*': 1}
let g:apc_min_length = 1
let g:apc_cr_confirm = 1
set cpt=.,w,b,u,U,k,kspell,i,d
set completeopt=menu,menuone,noselect
set shortmess+=c

let g:wintabs_ui_modified = ' *'
let g:wintabs_ui_readonly = ' !'

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'Read Only' : ''
endfunction
function! LightlineModified()
    return &modifiable && &modified ? '*' : ''
endfunction
function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'unknown') : ''
endfunction

let g:lightline = {
    \'colorscheme': 'wombat',
    \'left': [
        \['mode', 'paste'],
        \['readonly', 'filename', 'modified'],
        \],
    \'active': {
        \'right': [
            \['lineinfo'],
            \['percent'],
            \['line', 'fileencoding', 'filetype'],
            \],
        \},
    \'component': {
        \'line': '%LL',
        \},
    \'component_function': {
        \'modified': 'LightlineModified',
        \'readonly': 'LightlineReadonly',
        \'filetype': 'LightlineFiletype',
        \}
    \}

let g:show_file_explorer = {}
let g:show_file_explorer[tabpagenr()] = 1

function! ToggleNetrw()
    let g:show_file_explorer[tabpagenr()] = g:show_file_explorer[tabpagenr()] ? 0 : 1
    :Lexplore
endfunction

function! TabNew()
    :tabnew
    let g:show_file_explorer[tabpagenr()] = 1
    :Lexplore
endfunction

nnoremap <TAB>f :call ToggleNetrw()<CR>
nnoremap <TAB>q :q<CR>:q<CR>
nnoremap <TAB>w <C-w>w
nnoremap <TAB>v <C-w>l:edit ~/.vimrc<CR>
nnoremap <TAB>s <C-w>l:terminal<CR><C-w>12_
nnoremap <TAB>d :WintabsClose<CR>
nnoremap <TAB>t :call TabNew()<CR>
nnoremap <C-j> 10j
nnoremap <C-k> 10k
nnoremap <C-s> :w<CR>
nnoremap [b :WintabsPrevious<CR>
nnoremap ]b :WintabsNext<CR>
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
