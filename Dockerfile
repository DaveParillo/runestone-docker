# FROM python:3.8-buster 
FROM python:slim

COPY requirements.txt /tmp/
RUN apt-get update \
    && apt-get install -y \
       graphviz \
       vim \
    && pip install -r /tmp/requirements.txt
RUN sed -i -e 's/,$(".footer").html("user not logged in")//g' /usr/local/lib/python3.9/site-packages/runestone/dist/runestone.js

WORKDIR /var/book
VOLUME /var/book

EXPOSE 8000

CMD [ "/bin/bash" ]

