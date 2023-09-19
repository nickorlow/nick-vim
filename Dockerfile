FROM ubuntu:22.04
RUN apt-get -y update && apt-get -y install git wget xclip unzip build-essential
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && tar xzvf nvim-linux64.tar.gz 
RUN /nvim-linux64/bin/nvim -c 'Lazy sync' -c 'qa!'
COPY ./home/ /root/
ENTRYPOINT ["tail","-F", "wait_forever"]
