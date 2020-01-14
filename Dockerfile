FROM python:3.7.6-slim-stretch

LABEL maintainer="SQL Server Engineering Team"

#SQLCMD/BCP
## apt-get and system utilities
RUN apt-get update && apt-get install -y \
	curl apt-transport-https debconf-utils \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y gnupg2 

## adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

## install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y -f msodbcsql mssql-tools 
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8


#SQLPKG


#MSSQL-CLI
RUN pip install mssql-cli

#MSSQL-Scripter
RUN pip install mssql-scripter

CMD /bin/bash 
