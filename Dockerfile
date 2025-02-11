FROM nginx:latest
COPY cide-auto/src /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
