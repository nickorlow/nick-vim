echo Building container...
docker build . -t nick-vim &> /dev/null

echo Starting container...
cur_dir=`pwd`
container_name=${cur_dir////$'_'}
container_name="${container_name:1}_$RANDOM"
docker run --name $container_name --network host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --mount type=bind,source="$(pwd)",target=/work -d nick-vim &> /dev/null

echo Execing into container...
docker exec -w /work -it $container_name /nvim-linux64/bin/nvim #'+set clipboard=xclip' 

echo Stopping container...
docker stop $container_name &> /dev/null
