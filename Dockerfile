FROM python:3-alpine AS builder

WORKDIR /usr/src/app

COPY requirements.txt /tmp/
RUN mkdir -p /local/wheels \
    && apk --no-cache --update add \
        gcc \
        gfortran \
        build-base \
        wget \
        freetype-dev \
        libpng-dev \
        libxml2-dev \
        libxslt-dev \
    && pip wheel --wheel-dir=/local/wheels -r /tmp/requirements.txt

FROM python:3-alpine AS runner

RUN mkdir -p /local/wheels
COPY requirements.txt /tmp/
COPY --from=builder /local/wheels /local/wheels
RUN apk --no-cache --update add \
        graphviz \
        ttf-freefont \
    && pip install --no-index --find-links=/local/wheels -r /tmp/requirements.txt \
    && rm -r /local/wheels /tmp/requirements.txt \
    && sed -i -e '/user not logged in/ d' /usr/local/lib/python3.8/site-packages/runestone/common/js/bookfuncs.js

VOLUME /var/book
WORKDIR /var/book

EXPOSE 8000

CMD [ "/bin/sh" ]

