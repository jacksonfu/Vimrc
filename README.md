# 目录
   * [安装环境](#安装环境)
      * [自动安装及配置vim(如果没有安装vim8.1或以上版本，将会自动安装)：](#自动安装及配置vim如果没有安装vim81或以上版本将会自动安装)
      * [基本快速跳转](#基本快速跳转)
      * [vim配置默认功能的快捷键](#vim配置默认功能的快捷键)
      * [此vim配置中的操作](#此vim配置中的操作)
         * [vim自身的骚操作](#vim自身的骚操作)
         * [一键编译](#一键编译)
         * [取消缩进和增加缩进](#取消缩进和增加缩进)
            * [Visual 模式下](#visual-模式下)
         * [关闭与离开窗口](#关闭与离开窗口)
      * [外部插件提供的操作](#外部插件提供的操作)
         * [vim-plug插件管理](#vim-plug插件管理)
         * [vim-interestingwords高亮单词](#vim-interestingwords高亮单词)
         * [在*.cpp和*.h文件间切换](#在cpp和h文件间切换)
         * [YCM代码补全和跳转](#ycm代码补全和跳转)
         * [NERDtree目录树](#nerdtree目录树)
         * [markdown-previewmarkdown 即时预览](#markdown-previewmarkdown-即时预览)
         * [scrooloose/nerdcommenter快速注释](#scrooloosenerdcommenter快速注释)
         * [Lokaltog/vim-easymotion快速移动](#lokaltogvim-easymotion快速移动)
         * [SirVer/ultisnips模板补全](#sirverultisnips模板补全)
         * [LeaderF搜索文件，函数](#leaderf搜索文件函数)
         * [vim-indent-guides缩进可视化](#vim-indent-guides缩进可视化)
         * [wildfire.vim结对符内编辑](#wildfirevim结对符内编辑)
         * [ctrlsf.vim查找并替换](#ctrlsfvim查找并替换)
         * [vim-multiple-cursors多处替换相同的单词](#vim-multiple-cursors多处替换相同的单词)
         * [airblade/vim-gitguttergit操作](#airbladevim-gitguttergit操作)
         * [vim-airline/vim-airlinetabline](#vim-airlinevim-airlinetabline)
      * [Reference](#reference)

# 安装环境
- system: Ubuntu 16.04(docker镜像中测试通过)
- dependency
```
sudo apt-get install autoconf curl wget git cmake libncurses5-dev python-dev python3-dev \
                    ruby-dev lua5.1 lua5.1-dev ctags
```
## 自动安装及配置vim(如果没有安装vim8.1或以上版本，将会自动安装)：
自行选择版本:[release](https://github.com/jacksonfu/Vimrc/releases)
```
cd /path/to/vimrc
chmod +x install.sh
./install.sh
```

## 基本快速跳转
```
normal模式下:
hjkl          光标左下上右移
<ctrl>f 下翻页 <ctrl>b 上翻页 
<ctrl>u 上移半屏 <ctrl>u 下移半屏
0 行首 ^行首开始的第一个非空白字符 $行尾
gg 第一行  G最后一行
:n 跳到第n行 或者nG 跳转到第n行
w 下一个单词开头   b 上一个单词头  e 下一个单词尾
W 下一个单词开头   B 上一个单词头  E 下一个单词尾(空格分隔作为一个单词，很实用）
f后+这一行要去到的第一个字符，如f;去到光标后，该行第一个出现的;处，如不存在不跳转
M  当前页面中间开头处   H页面第一行开头   L页面最后一行开头
gm 移动到行中  gj光标下移一行，忽略自动换行  gk光标上移一行，忽略自动换行
<ctrl+o> 适用于函数跳转，文件数跳转后返回原处等跳转操作,不使用hjkl  <ctrl+i>相反操作

补充：
d+一些跳转命令可以获得删除到该跳转可达部分：
d0 d^ d$=D dw dgg dG
```

## vim配置默认功能的快捷键
```
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
```
```
" 定义快捷键到行首和行尾
" 0
nmap <Leader>e $
" 向前跳转行内的字母
nmap <Leader>f F

" 在插入模式并且必要情况下不需要移动到方向键上
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
```
```
" 需要vim8.0以上版本，并且支持clipboard 
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
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


" 快捷键 F11 实现桌面版全屏/窗口模式切换
map <silent> <F11> :call ToggleFullscreen()<CR>
```
```
解决复制到vim下会自动缩进和自动加注释的问题
先 :set paste 进入复制模式
再进入insert模式，再粘贴
" f2进入或者退出paste模式
```

## 此vim配置中的操作
### vim自身的骚操作
可能会遇到需要在复制一段代码后，想在这一大段代码前或者后同时加入一些东西，比如同时注释，或者同时加分号等等。
- vim自身的列模式写前面的步骤为：可视模式选取这一大段，ctrl-v进入列模式，输入I在其前编辑，esc一次表示退出该输入模式，esc两次才是退出列模式。
- **使用替换操作**。
```
替换操作的命令为
:[range]s/pattern/string/[c,e,g,i]
c表示替换前确认，e表示不显示错误信息，g表示整行替換，否则仅为第一个，i表示不区分大小写
$ 代表一行的结尾处
^ 代表一行的开头处
替换时选择作用范围，如：
当前行.与接下来两行+2
:.,+2s/foo/bar/g
替换第n行（从1开始）开始到最后一行中每一行的第一个vivian为sky
:n,$s/vivian/sky/
也可以在v可视选中代码后可以在选中区域内进行替换，在选中范围的代码末尾加入分号
:'<,'>s/$/;/g
在全局范围(%)查找foo并将每一行中的foo替换为bar
:%s/foo/bar/g
有时候需要替换前进行确认，如下面例子，想全局替换foo为bar并且每次替换前确认
:%s/foo/bar/gc
回车后Vim会将光标移动到每一次"foo"出现的位置，并提示
(y/n/a/q/l/^E/^Y)?
y:替换,n:不替换,a:替换所有,q:退出查找模式， 
l:替换当前位置并退出。^E:上滚,^Y:下滚
```

### 一键编译
```
func! CompileRun()
    exec "w"
    exec '!cd %:h && ./build.sh'
endfunc
nmap <F7> :call CompileRun()<CR>
```
在项目的目录下新建build.sh，里边编写编译规则，便可以使用F7进行快速编译


### 取消缩进和增加缩进
#### Visual 模式下 
```
normal 模式下按v 即进入VISUAL模式，可选择多行
选择好需要缩进的行后，按一次大于号’>’缩进一次，按’6>’缩进六次，按’<’回缩
```

### 关闭与离开窗口
```
有4种关闭窗口的方式，分别是：离开（quit）、关闭（close）、隐藏（hide）、关闭其他窗口
离开当前窗口Ctrl + W + q
关闭当前的窗口Ctrl + W + c
关闭当前窗口以外的所有窗口Ctrl + W + o
```

## 外部插件提供的操作

### `vim-plug`插件管理
```
vim-plug安装插件更加快速
下载vim-plug到~/.vim/autoload/plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
接下来在 .vimrc 增加相关配置信息：
call plug#begin('~/.vim/plugged')
...
Plug 'Lokaltog/vim-powerline'
...
call plug#end()
其中，每项Plug 'Lokaltog/vim-powerline'对应一个插件，后续若有新增插件，只需追加即可。
begin('~/.vim/plugged')表示安装插件到~/.vim/plugged目录下
补充插件后进入vim，然后执行
:PluginInstall
安装插件也可以先在.vimrc中加入插件配置后，再在命令行中执行
vim +'PlugInstall --sync' +qall
便可通知 vim-plug 自动安装该插件及其帮助文档。
要卸载插件，先在 .vimrc 中注释或者删除对应插件配置信息，然后在 vim 中执行
:PluginClean
更新
:PluginUpdate
```

### `vim-interestingwords`高亮单词
```
;k 高亮单词光标指向的单词
;K 取消高亮
;n 跳到下一个高亮处
;N 跳到上一个高亮处
```

### 在`*.cpp`和`*.h`文件间切换
```
;sw 跳转
```

### `YCM`代码补全和跳转
```
注意：ycm无法跨编译单元跳转到定义
;gy :YcmCompleter GoTo(实测，先跳本编译单元的定义，再跳声明，但是无法从声明跳回定义)
;sd :YcmShowDetailedDiagnostic 展示ycm诊断光标所指的行的细节(show debug)
let g:ycm_key_list_stop_completion = ['<C-y>']
control+y: 关闭补全提示

需要先在项目的目录生成compile_commands.json,一些构建工具生成的方法如下:
1.cmake
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON…
或者
CMakeLists.txt:
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
2.make
先安装bear(https://github.com/rizsotto/Bear),接着bear make(-j ...)
3.ninja
ninja (...) -t compdb cc > compile_commands.json
```

### `NERDtree`目录树
```
nmap <Leader>fl :NERDTreeToggle<CR>
;fl:打开/关闭目录树
o:打开文件，文件夹
s:打开文件并水平分割
r:刷新工程目录文件列表
I:显示/隐藏隐藏文件
m:出现创建/删除/剪切/拷贝操作列表
```

### `markdown-preview`markdown 即时预览
```
    MarkdownPreview
    " 在打开 markdown 文件后，使用该命令可以打开预览窗口
    MarkdownPreviewStop
    " 关闭 markdown 预览窗口，并停止开启的服务进程
```
```
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
let g:mkdp_path_to_chrome = "/opt/google/chrome/chrome"(替换为自身启动chrome的命令，可以用ps aux查询打开的chrome的启动命令)
```

### `scrooloose/nerdcommenter`快速注释
```
;c<space> 注释或者取消注释
```

### `Lokaltog/vim-easymotion`快速移动
```
;;w 可以跳转到光标后的位置
;;b 可以跳转到光标前的位置
;;s 搜索跳转，输入要搜索的字母
;;j 行级向下跳转
;;k 行级向上跳转
;;h 行内向左跳转
;;k 行内向右跳转
;;. 重复上一次动作
```

### `SirVer/ultisnips`模板补全
```
.vimrc 中设置放置补全文件目录
let g:UltiSnipsSnippetDirectories=["mysnippets"]
只有在~/.vim/mysnippets设置的目录中才能在ycm的补全列表中显示
;<tab> 模板展开或者跳转到下一处
<shift><tab> 跳转到上一处
```

### `LeaderF`搜索文件，函数
```
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
关闭了第一列的乱码显示：https://github.com/Yggdroot/LeaderF/issues/588#issuecomment-623236506
```

### `vim-indent-guides`缩进可视化
;i 开/关缩进可视化

### `wildfire.vim`结对符内编辑
```
适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]
空格 快速选中结对符内的文本
```

### `ctrlsf.vim`查找并替换
```
使用方法
:CtrlSF [arguments] {pattern} [path] ...
nnoremap <Leader>sp :CtrlSF<space>
;sp 再输入需要搜索的关键词，即可在工程内全局查找光标所在关键字
 <C-J> <C-K> 跳到下一个或者上一个匹配
o 打开该文件 p 预览 u 恢复
搜索制定文件 :CtrlSF <pattern> *.py
<C-J> <C-K> 跳到下一个或者上一个匹配
o 打开该文件 p 预览 u 恢复 q 退出
enter 打开光标指向的某文件的某行
搜索指定文件 :CtrlSF <pattern> *.py
:CtrlSFOpen :CtrlSFToggle 重新打开关闭的窗口
M 在跳转结果中键入时，可以打开一个类似quickfix窗口的结果
```

### `vim-multiple-cursors`多处替换相同的单词
```
ctrl+n 选中,接着ctrl+n选中下一个
ctrl+p 放弃一个, 回到上一个
ctrl+x 跳过当前选中, 选中下一个
esc 退出
选中后, 可以进行增删替换a/c/x等
```

### `airblade/vim-gitgutter`git操作
```
]c   跳转到下一个diff处
[c   跳转到上一个diff处
hunk：有变化的代码块
<leader>hs   先选择几行，然后执行就可以git add this hunk
<leader>hu   先选择几行，然后执行就可以git checkout this hunk
<leader>hp   preview
```

### `vim-airline/vim-airline`tabline
```
第1-10个tab(需要更多tab时设置 buffer_idx_mode 为2或者3
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
前一个，后一个tab
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
```

## Reference
- https://github.com/yangyangwithgnu/use_vim_as_ide
- https://github.com/yyzybb/cppenv
- https://www.zhihu.com/question/47691414
