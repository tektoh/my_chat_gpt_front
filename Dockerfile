ARG NODE_VERSION=18.15
FROM node:${NODE_VERSION}-buster AS base

ARG NODE_ENV=production

ENV APP_DIR /app
WORKDIR $APP_DIR

ARG API_SERVER_URL

ENV API_SERVER_URL=${API_SERVER_URL}

ENV TZ="Asia/Tokyo"
ENV NODE_ENV=$NODE_ENV
ENV PATH="${PATH}:./bin:./node_modules/.bin"

FROM base AS builder
COPY . $APP_DIR
RUN npm ci --include=dev --unsafe-perm
RUN npm run build

FROM base
ENV TINI_VERSION="v0.19.0"
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENV HOST=0.0.0.0 PORT=3000

RUN useradd app
USER app:app
WORKDIR $APP_DIR

COPY --from=builder --chown=app:app $APP_DIR/.nuxt $APP_DIR/.nuxt
COPY --from=builder --chown=app:app $APP_DIR/.output $APP_DIR/.output
COPY --chown=app:app tsconfig.json $APP_DIR/tsconfig.json

ENTRYPOINT ["/tini", "--"]
CMD ["node", ".output/server/index.mjs"]
EXPOSE 3000