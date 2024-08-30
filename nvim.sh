DISP=$DISPLAY
eval "$(micromamba shell hook --shell=zsh)" &&\
    micromamba activate neovim 2> /dev/null &&\
    export DISPLAY=$DISP &&\
    nvim $@  2> /dev/null&&\
    micromamba deactivate neovim 2> /dev/null
