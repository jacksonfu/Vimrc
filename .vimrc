" 定义快捷键的前缀，即 <Leader>
let mapleader=";"

" language setting
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
set backspace=2
set nofixendofline

" 按f2退出或者进入paste模式
set pastetoggle=<F2>

" 在插入模式并且必要情况下不需要移动到方向键上
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 设置快捷键实现一键编译及运行
func! CompileRun()
    exec "w"
    exec 'AsyncRun -raw sh <cwd>/build.sh'
endfunc
noremap <silent><F7> :call CompileRun()<CR>
" 显示文件内容
func! Catfile()
    exec "w"
    exec '!cat %'
endfunc
nmap <F9> :call Catfile()<CR>

" vim 自身（非插件）快捷键
" 行尾
nmap <Leader>e $

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>wq :w<CR>:q<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>wa :wa<CR>:q<CR>
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>qn :q!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 插件管理
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/indexer.tar.gz'
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'vim-scripts/DrawIt'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe'
Plug 'jacksonfu/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'gcmt/wildfire.vim'
Plug 'sjl/gundo.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'iamcco/markdown-preview.vim'
Plug 'lfv89/vim-interestingwords'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/vim-preview'
Plug 'Shougo/echodoc.vim'
Plug 'vim-scripts/a.vim'
Plug 'justinmk/vim-dirvish'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" 配色方案
" let g:solarized_termcolors=256
set t_Co=256
set background=dark
"colorscheme gruvbox

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 禁止折行
set nowrap

" 语法分析
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 缩进
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4


" 缩进可视化插件 vim-indent-guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle


" 代码折叠
" 基于缩进或语法进行代码折叠
" set foldmethod=indent
" set foldmethod=syntax
" 启动 vim 时关闭折叠代码
" set nofoldenable
" set foldlevelstart=99


" 头文件和源文件之间快速切换 
nmap <silent> <Leader>sw :A<cr>


" UltiSnips模板补全
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"


" YouCompleteMe
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=1
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_show_diagnostics_ui = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_clangd_args=['-index']
set completeopt=menu,menuone
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
nnoremap <leader>gy :YcmCompleter GoTo<CR>
nnoremap <leader>sd :YcmShowDetailedDiagnostic<CR>
 

" NERDTree 工程文件浏览
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=22
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" vim只剩下nerdtree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 设置忽略文件
let NERDTreeIgnore=['\.d$','\.o$','\.swp$','\.tgz$','\.clangd$']


" wildfire结对符
" 快速选中结对符内的文本
map <SPACE> <Plug>(wildfire-fuel)
" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]


" markdown preview
let g:mkdp_path_to_chrome = "/opt/google/chrome/chrome"
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
" 如果设置了该参数, g:mkdp_browserfunc 将被忽略
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" vim 回调函数, 参数为要打开的 url
let g:mkdp_auto_start = 1 
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
" markdown 文件的时候打开一次
let g:mkdp_auto_open = 1 
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预览窗口
let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
" 自动关闭预览窗口
let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
" 更新预览
let g:mkdp_command_for_global = 0
" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
" 文件可以使用改命令
let g:mkdp_open_to_the_world = 0
" 设置为 1, 在使用的网络中的其他计算机也能访问预览页面
" 默认只监听本地（127.0.0.1），其他计算机不能访问


" 高亮插件-vim-interestingwords
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>
" color for a terminal
let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']


" Asyncrun异步运行命令
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap qf :call asyncrun#quickfix_toggle(6)<cr>


" nerdcommenter快速注释
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1


" easymotion快速移动
let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作
map <Leader><leader>. <Plug>(easymotion-repeat)


" vim-preview 预览定义
" P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
noremap <Leader>u :PreviewScroll -1<cr> " 往上滚动预览窗口
noremap <leader>d :PreviewScroll +1<cr> "  往下滚动预览窗口k


" airblade/vim-gitgutter 版本控制


" LeaderF函数列表
let g:Lf_StlColorscheme = 'powerline'
"<C-P>  preview
"<ESC>  quit the leaderf
"<C-J> <C-K>  move the cursor in result window
"<C-X> : open in horizontal split window.
"<C-]> : open in vertical split window
":LeaderfRgRecall: recall last seach
" search tag or function
noremap <leader>tf :LeaderfFunction<cr>
" 避免nerdtree的<Leader>fl冲突
" <leader>sf: search file
noremap <leader>sf :LeaderfFile<cr>
" <leader>b :search file in buffer 
let g:Lf_WindowHeight = 0.30
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']


" ctrlsf.vim 查找
" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字
nnoremap <Leader>sp :CtrlSF<space>


" vim-multiple-cursors多处替换
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" airline
let g:airline_theme='luna'
" 开启tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" buffer_idx_mode设置为1模式
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab


" echodoc.vim参数提示
set noshowmode
let g:echodoc_enable_at_startup = 1
