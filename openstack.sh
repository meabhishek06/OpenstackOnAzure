#!/bin/bash

yum update -y


#subscription-manager repos --enable rhel-server-rhscl-7-rpms
#yum install python27-python-pip
#scl enable python27 bash
#which pip
#pip -V



pip install gdown

gdown   --id   1jfvs8xH40mCgjYBI1FxGO9F1QMq0WNdR    --output    rhel-7-server-additional-20180628.iso

gdown   --id   1G7KbibHG9KDsNe9Z-v2ru_Hyq93aOlnA   --output    rhel-7.5-server-updates-20180628.iso

gdown   --id   1fXVE8s_ntnQ4E-zfmTL0_jqS8_aQDJT-    --output    RHEL7OSP-13.0-20180628.2-x86_64.iso

mkdir /updates  /additional  /RHOSP

mount -o loop rhel-7.5-server-updates-20180628.iso  /updates/

mount -o loop rhel-7-server-additional-20180628.iso  /additional/

mount -o loop RHEL7OSP-13.0-20180628.2-x86_64.iso /RHOSP/

mkdir /software

cp -rvf /updates/  /software/

cp -rvf /additional/  /software/

cp -rvf /RHOSP/  /software/

yum install createrepo  -y

createrepo -v /software/.

cat <<EOF > /etc/yum.repos.d/openstack.repo
[Openstack]
name=Openstack
baseurl=file:///software
gpgcheck=0
EOF


yum clean all

#yum install python-setuptools -y


yum repolist

yum install python-setuptools -y

yum install openstack-packstack -y

systemctl stop NetworkManager

systemctl disable NetworkManager

packstack --gen-answer-file=a.txt

echo 3 > /proc/sys/vm/drop_caches

packstack  --answer-file=a.txt

