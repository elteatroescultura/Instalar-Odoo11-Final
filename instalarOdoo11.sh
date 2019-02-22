#!/bin/bash
# 2019 Version Final

ODOOVERSION=11.0
DEPTH=10
PATHBASE=~/Developments/odoo11
PATHREPOS=~/Developments/odoo11/extra-addons

wk32="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-i386.tar.xz"
wk64="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz"

# Update and install Postgresql
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s $USER"

mkdir ~/Developments
mkdir $PATHBASE
mkdir $PATHREPOS
cd $PATHBASE
# Download Odoo from git source
git clone https://github.com/odoo/odoo.git -b $ODOOVERSION --depth $DEPTH

# Install python3 and dependencies for Odoo
sudo apt-get install gcc python3-dev libxml2-dev libxslt1-dev \
 libevent-dev libsasl2-dev libldap2-dev libpq-dev \
 libpng-dev libjpeg-dev

sudo apt-get -y install python3 python3-pip python-pip
sudo pip3 install vobject qrcode num2words setuptools

# FIX wkhtml* dependencie Ubuntu Server 18.04
sudo apt-get install libxrender1

# Install nodejs and less
sudo apt-get install -y npm node-less
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less

# Download & install WKHTMLTOPDF
rm $PATHBASE/wkhtml*
if [ "`getconf LONG_BIT`" == "32" ];

then
	wget $wk32
else
	wget $wk64
fi

tar xvf $PATHBASE/wkhtmltox*.tar.xz
sudo cp -r $PATHBASE/wkhtmltox/bin/* /usr/local/bin/
sudo cp -r $PATHBASE/wkhtmltox/bin/* /usr/bin/


# install python requirements file (Odoo)
sudo pip3 install -r $PATHBASE/odoo/requirements.txt

echo "Odoo 11 Installation has finished!! ;) by odooerpcloud.com"



