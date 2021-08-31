# TFTP

## TFTP

## Dockerfile
```
## Se base sur l'image CENTOS 7
FROM centos:7
## Met à jour l'OS et install les outils necessaires pour tftp
RUN yum update -y \
  && yum install -y tftp-server tftp
## demare tftp server
ENTRYPOINT in.tftpd -L --secure /images/
```

## Construire le container

```
tdiprima@ansible:tftp [0] $ sudo docker build . -t tftp
Sending build context to Docker daemon  806.7MB
Step 1/3 : FROM centos:7
 ---> 0d120b6ccaa8
Step 2/3 : RUN yum update -y   && yum install -y tftp-server tftp
 ---> Using cache
 ---> 6a98f8e64155
Step 3/3 : ENTRYPOINT in.tftpd -L --secure /images/
 ---> Using cache
 ---> bc842cf6cc4b
Successfully built bc842cf6cc4b
Successfully tagged tftp:latest
```

## Demarrer le container
Sur le serveur portant le container, créer un dossier dans lequel vous souhaitez mettre les fichiers/images à utiliser avec tftp, ici ça sera /home/tdiprima/tftp/images/
```
tdiprima@ansible:tftp [0] $ sudo docker run -d -p 69:69 -v /home/tdiprima/tftp/images/:/images --name tftp tftp
011ea3a1d842d56dc80499ec48c90579536928dbba775af3e45527ce0252cc42
```
## Detruire le container
```
tdiprima@ansible:tftp [1] $ sudo docker rm tftp -f
tftp
```
## Verifier
```
[root@ee1915d944c0 /]# tftp 10.127.166.38
tftp> get test.test
[root@ee1915d944c0 /]# ls -l test.test
-rw-r--r-- 1 root root 0 Sep  2 12:47 test.test
[root@ee1915d944c0 /]# date
Wed Sep  2 12:47:19 UTC 2020
```
