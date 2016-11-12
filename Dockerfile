FROM debian:sid
MAINTAINER Nick Molnar <https://github.com/nickmolnar>
ENV LANG en
ENV PORT 5000

COPY ./requirements.txt /usr/spacyapi/requirements.txt

RUN apt-get update
RUN apt-get install -y python3 build-essential gcc g++ python3-dev python3-setuptools python3-pip
RUN export PIP_CERT=`python3 -m pip._vendor.requests.certs`

RUN pip3 install --upgrade pip setuptools
RUN pip3 install -r /usr/spacyapi/requirements.txt

RUN python3 -m spacy.${LANG}.download parser
COPY . /usr/spacyapi/

ENTRYPOINT cd /usr/spacyapi && python3 server.py

EXPOSE ${PORT}
