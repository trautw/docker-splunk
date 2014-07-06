# http://splunk.com

# https://index.docker.io/_/centos/
FROM centos

MAINTAINER Christoph Trautwein <trautwein@scientist.com>

# Update the base image.
RUN yum -y update
RUN yum -y install glibc.i686

# Install dependencies.
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Get splunk RPM
# requires splunk account
# ADD http://www.splunk.com/page/download_track?file=6.0/splunk/linux/splunk-6.0-182037-linux-2.6-x86_64.rpm&platform=Linux&architecture=x86_64&version=6.0&typed=release&name=linux_installer&d=pro&elq=dc39e7f3-1909-4410-a034-58d8e273fe67 /tmp/
ADD splunk-6.1.2-213098.i386.rpm /tmp/splunk-6.rpm

# use default install /opt/splunk
RUN yum -y --nogpgcheck localinstall /tmp/splunk-6.rpm 

# Remove yum metadata.
RUN yum clean all

# Install Splunk.
# ADD install.sh /tmp/
# RUN /tmp/install.sh

# Start Splunk.
# add enterprise license if applicable
# RUN /opt/splunk/bin/ ./splunk add licenses /opt/splunk/etc/licenses/enterprise/enterprise.lic

EXPOSE 8000

# Start splunk and accept the free license
CMD /opt/splunk/bin/splunk start --accept-license ; while true; do date; sleep 60; done

