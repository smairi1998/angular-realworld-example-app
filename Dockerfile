# Step 1: Build the Angular app
FROM node:18 AS build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the app for production (or development based on the environment)
ARG ENV=production
RUN if [ "$ENV" = "production" ]; then npm run build --prod; else npm run build; fi

# Step 2: Serve the Angular app using a simple HTTP server
FROM nginx:alpine

# Copy the build output from the build stage
COPY --from=build /app/dist/angular-conduit/browser /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
