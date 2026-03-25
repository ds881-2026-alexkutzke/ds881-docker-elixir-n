# Usa a imagen oficial do Elixir como imagen base ou no caso hereda de uma imagen Elixir
FROM elixir:1.15

# Prepara o diretório de trabalho, senão existe o cria e se situa nele
WORKDIR /app

# Copio o arquivo mix.exs ao diretorio atual da imagen, no caso na pasta app
COPY mix.exs .

# Instala Hex and Rebar
RUN mix local.hex --force
RUN mix local.rebar --force

# Instala as bibliotecas do Elixir
RUN mix deps.get

# Copia o resto dos arquivos da aplicação
COPY . .

# Compila a aplicação
RUN mix compile

# Expoe a porta da aplicação
EXPOSE 8080

# Iniciar a aplicação
CMD ["mix", "run", "--no-halt"]