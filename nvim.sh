echo Building container...
docker build . -t nick-vim #> /dev/null || (echo 'Error building container!' && exit) 

echo Starting container...
cur_dir=`pwd`
container_name=${cur_dir////$'_'}
container_name="${container_name:1}_$RANDOM"
docker run --name $container_name --network host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --mount type=bind,source="$(pwd)",target=/work -d nick-vim &> /dev/null

echo Installing plugins...
docker exec -w /work -it $container_name /nvim-linux64/bin/nvim --headless +Lazy -c "MasonInstall clangd rust-analyzer gopls omnisharp typescript-language-server python-lsp-server zls ocaml-lsp erlang-ls dockerfile-language-server yaml-language-server ltex-ls marksman html-lsp" +qall &> /dev/null

echo Execing into container...
docker exec -w /work -it $container_name /nvim-linux64/bin/nvim 

echo Stopping container in background...
docker stop $container_name &> /dev/null &
