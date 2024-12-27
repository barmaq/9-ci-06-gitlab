FROM centos:7

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install python3 python3-pip -y
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
WORKDIR /python_api
COPY python-api.py python-api.py
EXPOSE 5290
CMD ["python3", "python-api.py"]

