FROM elixir:1.2.3
EXPOSE 4000

RUN mkdir /app
WORKDIR /app
COPY . /app/
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile
CMD ["mix", "phoenix.server"]
