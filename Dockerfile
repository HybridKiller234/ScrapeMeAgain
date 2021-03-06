FROM alpine:3.6

MAINTAINER "Dušan Maďar"

ENV SRCDIR=/scp
ENV PYTHONPATH=$SRCDIR

RUN \
    apk --update add --no-cache \
        tor \
        privoxy \
        python3 \
        python3-dev \
        git \
        libressl

COPY requirements.txt $SRCDIR/requirements.txt

RUN \
    wget -O /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" && \
    python3 /tmp/get-pip.py && \
    pip3 install -U pip && \
    pip3 install -r $SRCDIR/requirements.txt

WORKDIR $SRCDIR

# The line belows adds postgres support and another 120 mb to the image size.
# RUN apk add --update --no-cache gcc musl-dev postgresql-dev
