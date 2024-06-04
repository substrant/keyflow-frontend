FROM oven/bun:alpine AS base

# Set up shared 'srv' group
ARG SRV_GROUP_ID
RUN addgroup -g $SRV_GROUP_ID srv

# Assign default group to root and bun
RUN /usr/sbin/usermod -g srv root
RUN /usr/sbin/usermod -g srv bun

# Set the working directory
WORKDIR /app

##########################################################################################

### Install dependencies into a temporary directory ###
FROM base AS install

RUN mkdir /tmp/app_install
COPY package.json bun.lockb /tmp/app_install/
RUN cd /tmp/app_install && bun install --frozen-lockfile

##########################################################################################

### Release the application to production ###
FROM base AS prod

# Install dependencies into the app directory
COPY --from=install /tmp/app_install/node_modules ./node_modules
COPY . .

# Build and copy to /var/www ###
ENV NODE_ENV=production
RUN bun run build
CMD [ "bun", "run", "deploy" ]

##########################################################################################

### Run the application in development mode ###
FROM base AS dev

# Install dependencies into the app directory
COPY --from=install /tmp/app_install/node_modules ./node_modules
COPY . .

# Expose port for dev app and run the application
EXPOSE 8443
ENV NODE_ENV=development
ENTRYPOINT [ "bun", "run", "dev" ]

##########################################################################################