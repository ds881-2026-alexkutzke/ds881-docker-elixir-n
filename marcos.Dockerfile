FROM elixir:1.14-alpine AS build

ENV MIX_ENV=prod

WORKDIR /app

RUN apk add --no-cache build-base git

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs ./

RUN mix deps.get --only $MIX_ENV && \
    mix deps.compile

COPY lib lib

RUN mix compile && \
    mix release

FROM alpine:3.18 AS runtime

RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app

COPY --from=build /app/_build/prod/rel/calculadora_api ./

EXPOSE 8080

ENV HOME=/app

CMD ["bin/calculadora_api", "start"]
