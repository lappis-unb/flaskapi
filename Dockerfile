FROM debian:buster-slim

RUN mkdir /apipromova
WORKDIR /apipromova

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-pyodbc \
        python3-simplejson \
        python3-click \
        python3-flask \
        python3-itsdangerous \
        python3-jinja2 \
        python3-markupsafe \
        python3-werkzeug \
        tdsodbc \
        unixodbc \
        freetds-bin
RUN apt-get clean

RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
# ADD ./setup.py /apipromova/

ADD ./requirements.txt /apipromova/
ADD ./odbcinst.ini /etc/odbcinst.ini

RUN pip3 install -r requirements.txt
# RUN python3 setup.py develop
ADD . /apipromova/

EXPOSE 5000
ENV FLASK_ENV=development
ENV FLASK_APP=/apipromova/app.py
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000", "--debugger"]
