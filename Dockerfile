FROM node:17-stretch

# Set npm global directory for the non-root user
RUN mkdir -p /home/nodejs/.npm-global \
    && npm config set prefix /home/nodejs/.npm-global

# Install yarn globally
RUN npm install -g yarn

# Create a non-root user and set permissions
RUN groupadd nodejs && useradd -ms /bin/bash -g nodejs nodejs
RUN mkdir -p /var/prod && chown -R nodejs:nodejs /var/prod

# Switch to non-root user
USER nodejs

# Set working directory
ENV workdir /var/prod
WORKDIR ${workdir}

# Copy files
COPY --chown=nodejs:nodejs package*.json ./
COPY --chown=nodejs:nodejs tsconfig.json ./
COPY --chown=nodejs:nodejs src ./src

# Install dependencies using yarn
RUN yarn install

# Build the app
RUN yarn build-ts

# Expose port
EXPOSE 7000

# Start the app
CMD ["yarn", "start"]
