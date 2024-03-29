###################
# BUILD FOR LOCAL DEVELOPMENT
###################
# In this step we copy over everything we need and install all dependancies
# We stop at the end of this step in development, so it also includes the deploy command
# We install jest, eslint and ts-node so we can run tests and lint.

FROM node:20.5-alpine

ENV TZ="America/Chicago"
ENV NODE_ENV=development
RUN date

# Create app directory
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY --chown=node:node package*.json ./

# Install app dependencies using the `npm ci` command instead of `npm install`
# Use NPM CI even though this may be your first time, cuz package-lock already thinks you installed stuff
RUN npm ci

# Bundle app source
COPY --chown=node:node . .

# Use the node user from the image (instead of the root user)
USER node
