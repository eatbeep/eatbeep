FROM elixir:1.11.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base yarn make gcc libc-dev

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/yarn.lock ./assets/
# RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error
RUN yarn --cwd ./assets --frozen-lockfile --no-progress 

COPY priv priv
COPY assets assets
RUN yarn --cwd ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
# FROM alpine:3.12 AS app
# RUN apk add --no-cache openssl ncurses-libs

# WORKDIR /app

# RUN chown nobody:nobody /app

# USER nobody:nobody

# COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/eatbeep ./

# ENV HOME=/app

# CMD ["bin/eatbeep", "start"]