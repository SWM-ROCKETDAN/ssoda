FROM python:3.8
ENV PYTHONUNBUFFERED 1
WORKDIR /usr/src/app/
COPY server server/
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
WORKDIR server/