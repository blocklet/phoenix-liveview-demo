FROM gitpod/workspace-full

# Install Erlang, Elixir, Hex and Rebar
USER root
ENV DEBIAN_FRONTEND=noninteractive

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb \
    && dpkg -i erlang-solutions_2.0_all.deb \
    && apt-get update \
    && apt-get install esl-erlang -y \
    && apt-get install elixir -y \
    && apt-get install inotify-tools -y \
    && mix local.hex --force \
    && mix local.rebar --force \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
    
# Install ABT Node and its dependencies
ENV ABT_NODE_TEST_DOCKER=1
ENV PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
ENV ABT_NODE_HTTP_PORT=8080
ENV ABT_NODE_HTTPS_PORT=4430
RUN brew install nginx \
  && npm install -g lerna @abtnode/cli@1.0.24
