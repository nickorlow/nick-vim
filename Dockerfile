FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Install base deps + C(++) build tools + Python3 + Golang + OCaml
RUN apt-get -y update && apt-get -y install git wget xclip unzip build-essential gnupg python3 golang apt-transport-https software-properties-common lsb-release python3-venv opam rebar3

# Install neovim
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz && tar xzvf nvim-linux64.tar.gz 

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash -
RUN apt-get -y install nodejs npm

# Install Erlang
RUN curl -1sLf 'https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/setup.deb.sh' | bash
RUN apt-get update -y
RUN apt-get install -y erlang

# Init Ocaml
RUN opam init --disable-sandboxing

# Copy files
COPY ./home/ /root/

# Install Nvim  Packages
RUN /nvim-linux64/bin/nvim --headless +Lazy -c "MasonInstall clangd rust-analyzer gopls omnisharp typescript-language-server python-lsp-server zls ocaml-lsp erlang-ls dockerfile-language-server yaml-language-server ltex-ls marksman html-lsp" +qall 

ENTRYPOINT ["tail","-F", "wait_forever"]
