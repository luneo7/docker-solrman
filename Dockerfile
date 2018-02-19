
FROM    golang:alpine
MAINTAINER Lucas Rogerio Caetano Ferreira "luneo7@gmail.com"

RUN apk add --no-cache \
        git \
        bash

ENV SOLRMAN_USER="solr" \
    SOLRMAN_UID="8983" \
    SOLRMAN_GROUP="solr" \
    SOLRMAN_GID="8983" \
    GOPATH="/opt/solrman" \
    ZK_HOST="" \
    PATH="/opt/solrman/bin:$PATH"

RUN addgroup -S -g $SOLRMAN_GID $SOLRMAN_GROUP && \
    adduser -S -u $SOLRMAN_UID -G $SOLRMAN_GROUP $SOLRMAN_USER

RUN mkdir -p /opt/solrman

WORKDIR /opt/solrman

RUN echo 'downloading solrman' && \
    go get github.com/fullstorydev/gosolr/...

RUN chown -R $SOLRMAN_USER:$SOLRMAN_GROUP /opt/solrman

EXPOSE 8984
USER $SOLRMAN_USER

ENTRYPOINT ["sh", "-c", "./bin/solrman -zkServers $ZK_HOST"]
