#!/bin/bash

# Source: http://toomuchdata.com/2012/06/25/how-to-install-python-2-7-3-on-centos-6-2/

# Update #
##########

yum update
yum upgrade
yum install wget
curl -O http://python-distribute.org/distribute_setup.py
python distribute_setup.py
easy_install pip

# Install stuff #
#################

# Install development tools and some misc. necessary packages
yum -y groupinstall "Development tools"
yum -y install zlib-devel  # gen'l reqs
yum -y install bzip2-devel openssl-devel ncurses-devel  # gen'l reqs
yum -y install mysql-devel  # req'd to use MySQL with python ('mysql-python' package)
yum -y install libxml2-devel libxslt-devel  # req'd by python package 'lxml'
yum -y install unixODBC-devel  # req'd by python package 'pyodbc'
yum -y install sqlite sqlite-devel  # you will be sad if you don't install this before compiling python, and later need it.

# Alias shasum to == sha1sum (will prevent some people's scripts from breaking)
echo 'alias shasum="sha1sum"' >> $HOME/.bashrc

# Install Python 2.7.5 (do NOT remove 2.6, by the way)
wget --no-check-certificate http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
tar xf Python-2.7.5.tar.bz2
cd Python-2.7.5
./configure --prefix=/usr/local
make && make altinstall

# Install virtualenv and virtualenvwrapper
wget --no-check-certificate https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.9.1.tar.gz#md5=07e09df0adfca0b2d487e39a4bf2270a
tar -xvzf virtualenv-1.9.1.tar.gz
cd virtualenv-1.9.1
python setup.py install

# Done!

# Extra stuff #
###############

# These items are not required, but I recommend them

# Add RPMForge repo
sudo yum -y install http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.i686.rpm
yum updateinfo
# Install trash-cli (safer than 'rm', see here: https://github.com/andreafrancia/trash-cli)
sudo yum -y install python-unipath
sudo yum install http://pkgs.repoforge.org/trash-cli/trash-cli-0.11.2-1.el6.rf.i686.rpm

# Add EPEL repo (more details at cyberciti.biz/faq/fedora-sl-centos-redhat6-enable-epel-repo/)
cd /tmp
wget --no-check-certificate http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm

# NGINX

yum -y install http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install nginx