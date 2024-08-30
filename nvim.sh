DISP=$DISPLAY
eval "$(micromamba shell hook --shell=bash)" && \ 
    micromamba activate neovim && \ 
    export DISPLAY=$DISP && \
    nvim $@ && \ 
    micromamba deactivate neovim
