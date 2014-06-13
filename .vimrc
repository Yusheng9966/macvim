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

syntax on


"在查找时忽略大小写
set ignorecase
set incsearch
set hlsearch
  
"显示匹配的括号
set showmatch

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
        " 半透明和窗口大小
        set transparency=2
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
