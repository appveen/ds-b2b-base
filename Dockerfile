FROM node:18-buster-slim

RUN apt update
RUN apt upgrade -y

RUN apt install -y curl tar git openssl


# RUN apk update
# RUN apk upgrade

# RUN apk add curl tar git openssl

WORKDIR /tmp/app

COPY package.json package.json

RUN npm install -g npm
RUN npm install --production --no-audit
# RUN npm audit fix --production
RUN rm -rf /usr/local/lib/node_modules/npm/node_modules/node-gyp/test

COPY app.js app.js
COPY common.utils.js common.utils.js
COPY config.js config.js
COPY db-factory.js db-factory.js
COPY flow.schema.json flow.schema.json
COPY http-client.js http-client.js
COPY lib.middlewares.js lib.middlewares.js
COPY schema.utils.js schema.utils.js
COPY state.utils.js state.utils.js

COPY generator/code.generator.js generator/code.generator.js
COPY generator/index.js generator/index.js
COPY generator/schema.utils.js generator/schema.utils.js
COPY generator/schema.validator.js generator/schema.validator.js

ENV NODE_ENV='production'


CMD [ "node", "app.js" ]