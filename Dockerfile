FROM python:3.7.6-slim-stretch

LABEL maintainer="SQL Server Engineering Team"

#SQLCMD/BCP
## install dependencies and system utilities
RUN apt-get update && apt-get install -y -f \
	curl apt-transport-https debconf-utils gnupg2 \
    && rm -rf /var/lib/apt/lists/*

## add custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

## install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y -f msodbcsql mssql-tools \
 && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
 && /bin/bash -c "source ~/.bashrc"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

#MSSQL-CLI
RUN echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" | tee /etc/apt/sources.list.d/mssql-cli.list
RUN apt-get update
RUN apt-get install -y mssql-cli

#MSSQL-Scripter
RUN pip install mssql-scripter

#SQLPKG
## install dotnet core runtime
RUN apt-get install -y libunwind8 unzip wget \
&& wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
&& mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
&& wget -q https://packages.microsoft.com/config/debian/9/prod.list \
&& mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
&& chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
&& chown root:root /etc/apt/sources.list.d/microsoft-prod.list \
&& apt-get -y install dotnet-runtime-3.1

## install sqlpackage
RUN curl -L https://go.microsoft.com/fwlink/?linkid=2113331 -o sqlpackage.zip \
&& mkdir /opt/sqlpackage \
&& unzip sqlpackage.zip -d /opt/sqlpackage  \
&& echo 'export PATH="$PATH:/opt/sqlpackage"' >> ~/.bashrc \
&& chmod a+x /opt/sqlpackage/sqlpackage \
&& /bin/bash -c "source ~/.bashrc"

ENV PATH "/opt/sqlpackage:${PATH}"
ENV PATH "/opt/mssql-tools/bin:${PATH}"

CMD /bin/bash 
