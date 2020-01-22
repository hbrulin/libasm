# libasm

#brew \
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update \

#nasm \
brew install nasm \

#compiling \
nasm -f macho64 test.s -o test.o \
#macho64 is object file for mac os
 

Each function contains a prologue at the beginning and an epilogue at the
end.
• The prologue sets-up the stack frame for the function by saving the base
pointer to the stack and moving the base pointer to the top of the stack.
Example:
pushq %rbp
mov %rsp, %rbp
• The epilogue cleans up the stack frame and restores the stack and base
pointers to the pre-call values and jumps to the saved return address
Example:
leave
ret
