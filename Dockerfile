FROM centos:7
RUN yum update -y \
  && yum install -y tftp-server tftp
ENTRYPOINT in.tftpd -L --secure /images/
