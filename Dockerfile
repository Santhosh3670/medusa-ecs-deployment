# Use the official Medusa image as base
FROM medusajs/medusa:latest

# Set working directory
WORKDIR /app/medusa

# Copy package files if you have custom dependencies
# COPY package.json package-lock.json ./

# Install any additional dependencies
# RUN npm install

# Copy custom configuration or plugins if needed
# COPY medusa-config.js ./
# COPY plugins/ ./plugins/

# Expose the port
EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:9000/health || exit 1

# Start the application
CMD ["npm", "start"]
