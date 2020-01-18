# libasm

#brew \
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update \

#nasm \
brew install nasm \

#compiling \
nasm -f macho64 test.s -o test.o \
#macho64 is object file for mac os
 