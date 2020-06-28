# OpenstackOnAzure

yum install git -y

git clone https://github.com/meabhishek06/OpenstackOnAzure.git

cd OpenstackOnAzure

chmod +x openstack.sh



subscription-manager repos --enable rhel-server-rhscl-7-rpms
yum install python27-python-pip
scl enable python27 bash
which pip
pip -V
./openstack.sh
