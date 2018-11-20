FROM alpine:latest

LABEL "com.github.actions.name"="Shaking Finger"
LABEL "com.github.actions.description"="Displays a gif of Conan shaking his finger to a pull request on fail"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="yellow"

RUN apk add --no-cache \
	bash \
	ca-certificates \
	coreutils \
	curl \
	jq

COPY add-comment.sh /usr/local/bin/add-comment

CMD ["add-comment"]
