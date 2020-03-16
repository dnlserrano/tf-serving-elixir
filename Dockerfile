FROM elixir:1.10

COPY . /home/app
WORKDIR /home/app

RUN apt-get update && \
  apt-get -y install \
  build-essential \
  erlang-dev

RUN mix local.hex --force && \
  mix local.rebar --force

EXPOSE 8000 8443

RUN chmod +x script/run.sh
ENTRYPOINT ["sh", "script/run.sh"]
