FROM nginx

RUN mkdir /ssoda

WORKDIR /ssoda

RUN mkdir ./build

ADD ./build/web ./build

RUN rm /etc/nginx/conf.d/default.conf

COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]