FROM debian:buster-slim

RUN mkdir /flaskapi
WORKDIR /flaskapi

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-pyodbc \
        tdsodbc \
        unixodbc \
        unixodbc-dev \
        freetds-dev \
        build-essential


RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
# ADD ./setup.py /flaskapi/

ADD ./requirements.txt /flaskapi/
ADD ./odbcinst.ini /etc/odbcinst.ini

RUN pip3 install -r requirements.txt
# RUN python3 setup.py develop
ADD . /flaskapi/

EXPOSE 8080
ENV FLASK_ENV=development
ENV FLASK_APP=/flaskapi/app.py
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080", "--debugger"]
