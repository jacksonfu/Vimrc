#!/bin/bash

set -e

. ./lib/lib.sh $@

function addBinPath()
{
    pathExist=`grep -c '^export PATH=\$HOME/bin:\$PATH' $PROFILE || true`
    if [ 0 -eq $pathExist ] ;then
        # 修复在执行脚本过程中vim not found的错误
        echo "export PATH=\$HOME/bin:\$PATH" >> $PROFILE
    fi
    source $PROFILE
    pathExist=`grep -c '^export PATH=\$HOME/bin:\$PATH' $HOME/.bashrc || true`
    if [ 0 -eq $pathExist ] ;then
        # 修复运行docker容器或者重启docker容器时vim not found的错误
        echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.bashrc
    fi
}

function install_vim()
{
    pkg=vim-8.1.tar.bz2

    cd $TMP
    download "ftp://ftp.vim.org/pub/vim/unix/vim-8.1.tar.bz2" $pkg
    tar jxf $pkg
    dir=`tar tf $pkg | head -1`
    cd $dir
    ./configure --with-features=huge --enable-multibyte \
        --enable-python3interp=yes --enable-rubyinterp=yes \
        --enable-luainterp=yes --enable-perlinterp=yes \
        --with-tlib=ncurses \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-cscope \
        --prefix=$PREFIX
    getMakeFlag
    make $MAKEFLAGS
    make install
}

cp .vimrc $TMP/
cp cpp.snippets $TMP/
cp c.snippets $TMP/
cp ycm_extra_conf.py $HOME/.ycm_extra_conf.py
# vim version >= 8.1
if [ -x "$(command -v vim)" ]; then
    validversion=8.1
    version=`vim --version | head -1 | awk '{print $5}'`
    if version_ge $version $validversion ;then
        message "vim-version is great than or equal to vim-8.1, continue!"
    else
        message "vim-version is less than 8.1, and then vim-8.1 will be installed!"
        install_vim
        message "install vim-8.1 successfully!"
    fi
else
    message "vim-version is less than 8.1, and then vim-8.1 will be installed!"
    install_vim
    message "install vim-8.1 successfully!"
fi

addBinPath
# 备份.vimrc .vim
if [ -f "$HOME/.vimrc" ]; then
  mv $HOME/.vimrc $HOME/_vimrc
fi
if [ -d "$HOME/.vim" ]; then
  mv $HOME/.vim $HOME/_vim
fi
cp $TMP/.vimrc $HOME/

# install ack
if [ ! -x "$(command -v ack)" ]; then
    curl https://beyondgrep.com/ack-2.22-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
fi
# 安装插件
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qall
# fix colorscheme bug
sed -i 's/"colorscheme/colorscheme/' $HOME/.vimrc

# config UltiSnips
cd ~/.vim/
cp ~/.vim/plugged/vim-snippets/UltiSnips mysnippets -R
cp $TMP/cpp.snippets mysnippets/
cp $TMP/c.snippets mysnippets/

message "all plugins installed successfully, and then continue to config YCM"

cd $HOME/.vim/plugged/YouCompleteMe
python3 ./install.py --clang-completer --clangd-completer
mkdir $HOME/lib/ -p
ln -s $HOME/.vim/plugged/YouCompleteMe/third_party/ycmd/third_party/clang/lib/libclang.so.* $HOME/lib/
echo "export LD_LIBRARY_PATH=\$HOME/lib:\$LD_LIBRARY_PATH" >> $HOME/.bashrc
ldconfig
message "vim environment is installed successfully, enjoy it!!!"
