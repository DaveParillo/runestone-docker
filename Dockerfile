FROM python:3-alpine AS builder

WORKDIR /usr/src/app

COPY requirements.txt .
RUN apk --no-cache --update add \
        gcc \
        gfortran \
        build-base \
        wget \
        freetype-dev \
        libpng-dev \
        libxml2-dev \
        libxslt-dev
RUN mkdir -p /local/wheels \
    && pip wheel --wheel-dir=/local/wheels -r requirements.txt

FROM python:3-alpine AS runner
RUN mkdir -p /local/wheels
COPY requirements.txt .
COPY --from=builder /local/wheels /local/wheels
RUN apk --no-cache --update add \
        graphviz \
        ttf-freefont
RUN pip install --no-index --find-links=/local/wheels -r requirements.txt
RUN rm -r /local/wheels

VOLUME /var/book

EXPOSE 8000

CMD [ "/bin/sh" ]

