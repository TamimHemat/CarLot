FROM ubuntu:18.04

LABEL maintainer="tamimyasuo@gmail.com"

RUN apt-get update -y && \
apt-get install -y python-pip python-dev

RUN pip install SQLAlchemy
RUN pip install Flask
RUN pip install Xmlrunner

#Sorry but these package version just don't work
# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

#RUN pip install -r requirements.txt

COPY . /app

RUN cd /app && python create_tables.py

ENTRYPOINT [ "python" ]

CMD [ "car_api.py" ]
