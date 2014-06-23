" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

"显示匹配的括号
set showmatch

"在查找时忽略大小写
set ignorecase
set incsearch
set hlsearch

syntax on
filetype on
filetype plugin on "ftplugin.vim will load otherwise use ftplugof.vim
filetype indent on "indent.vim will load

let Tlist_Ctags_Cmd='~/.vim/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 1

"将光标在窗口的底和顶移动
function MoveCursorToTopBottm()
    let s:cur_line=line(".")
    let s:top_line = line("w0")
    let s:bottom_line = line("w$")
    if s:cur_line != s:bottom_line 
        exe "normal" (s:bottom_line - s:cur_line)."j"
    else
        exe "normal" (s:cur_line-s:top_line)."k"
    endif
endfunction

"将光标移动到Taglist窗口
function MoveCursorToTaglist()
    let s:_cur_winnr = winnr()
    let s:winnum =  bufwinnr(g:TagList_title)
    if s:_cur_winnr == s:winnum 
        exe s:_last_winnr . 'wincmd w'
    else
        exe s:winnum . 'wincmd w'
        let s:_last_winnr = s:_cur_winnr
    endif
endfunction

function MyRun()
    exe "w"
    if &filetype == "markdown"
        "exe "!$HOME/.vim/markdown.pl --html4tags % > %.html &"
        "exe "!open %.html &"
        exe "!open -a /Applications/Google\\ Chrome.app %"
    endif
endfunction

map <silent> <leader>tl :TlistToggle<cr>
map <silent> <F7> :call MoveCursorToTaglist()<cr>
"将选中行注释和取消注释
vmap <buffer> <leader>kc :!python $HOME/.vim/pycoment.py<cr>
vmap <buffer> <leader>ku :!python $HOME/.vim/pycoment.py 2<cr>
"将光标移动到窗口顶部和底部
nmap <space> :call MoveCursorToTopBottm()<cr>
nmap <leader>rr :call MyRun()<cr>


" =========
" 图形界面
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr
  
    " 高亮光标所在的行
    set cursorline
  
    " 编辑器配色
    "colorscheme zenburn
    "colorscheme dusk
    colorscheme desert
  
    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim
  
        " f11 最大化
        nmap <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>
        nmap <Leader>ff :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>
 
        " 自动最大化窗口
        au GUIEnter * simalt ~x
 
        " 给 Win32 下的 gVim 窗口设置透明度
        au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 250)
  
        " 字体配置
        exec 'set guifont='.iconv('Courier_New', &enc, 'gbk').':h11:cANSI'
        exec 'set guifontwide='.iconv('微软雅黑', &enc, 'gbk').':h11'
    endif
  
    if has("unix") && !has('gui_macvim')
        set guifont=Courier\ 10\ Pitch\ 11
        set guifontwide=YaHei\ Consolas\ Hybrid\ 11
    endif
  
    if has("gui_macvim")
        " MacVim 下的字体配置
        set guifont=Menlo:h14
        set guifontwide=Hei:h12
        " 半透明和窗口大小 set transparency=2
        set lines=40 columns=110
  
        " 使用MacVim原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns
         
        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf
  
        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf
  
        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf
 
        " Mac 下，按 \\ 切换全屏
        nmap <Leader><Leader>  :call FullScreenToggle()<cr>
 
        " Set input method off
        set imdisable
  
        " Set QuickTemplatePath
        let guickTemplatePath = $HOME.'/.vim/templates/'
         
        " 如果为空文件，则自动设置当前目录为桌面
        lcd ~/Desktop/
  
        " 自动切换到文件当前目录
        set autochdir
  
        " Set QuickTemplatePath
        let guickTemplatePath = $HOME.'/.vim/templates/'
 
    endif
endif
