FROM alpine:3.6
LABEL maintainer="stjepan@udovicic.org"
EXPOSE 80

RUN apk update && apk upgrade && apk add varnish

ADD start.sh /start.sh
CMD ["/start.sh"]