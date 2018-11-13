FROM alpine:latest

RUN apk add --no-cache \
	bash \
	ca-certificates \
	curl

COPY add-comment.sh /usr/local/bin/add-comment

CMD ["add-comment"]
