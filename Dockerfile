# stage1 - build react app first 
FROM node:15.4 as build 
WORKDIR /react-app
COPY package*.json .
RUN yarn install
COPY . .
RUN yarn run build

# stage 2 - build the final image and copy the react build files
FROM nginx:1.19
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /react-app/build /usr/share/nginx/html
