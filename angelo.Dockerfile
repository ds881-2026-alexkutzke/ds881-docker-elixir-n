#https://elixir-lang.org/install.html
#https://hub.docker.com/layers/library/elixir/1.14
FROM elixir:1.14
WORKDIR /usr/src/app
COPY mix.exs .
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
COPY . .
RUN mix compile
#Execução
EXPOSE 8080
CMD [ "mix", "run", "--no-halt" ]