#https://elixir-lang.org/install.html
#https://hub.docker.com/layers/library/elixir/1.14
FROM elixir:1.14 AS build
WORKDIR /usr/src/app
COPY mix.exs mix.lock ./
RUN mix local.hex --force
RUN mix local.rebar --force
ENV MIX_ENV=prod
RUN mix deps.get --only prod
COPY . .
RUN mix compile && mix release
FROM gcr.io/distroless/cc-debian12
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/_build/prod/rel/calculadora_api /app
COPY --from=build /usr/local/lib/erlang /usr/local/lib/erlang
ENV PATH="/usr/local/lib/erlang/bin:$PATH"
#Execução
EXPOSE 8080
CMD ["/app/bin/calculadora_api", "start"]