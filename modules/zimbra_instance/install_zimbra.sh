#!/bin/bash
set -e

DOMAIN_NAME="rahul.flyingspark.org"
ADMIN_PASSWORD="rahul@123"
INTERNAL_IP=$(hostname -I | awk '{print $1}')

# 1️⃣ Update /etc/hosts
if ! grep -q "$DOMAIN_NAME" /etc/hosts; then
    echo "$INTERNAL_IP $DOMAIN_NAME" >> /etc/hosts
fi

# 2️⃣ Install Dependencies
apt-get update -y
apt-get install -y net-tools curl

# 3️⃣ Download Zimbra
cd /home/ubuntu
wget https://download.zextras.com/zcs-9.0.0_OSE_UBUNTU18_latest-zextras.tgz

# 4️⃣ Extract Zimbra
tar -xvzf zcs-9.0.0_OSE_UBUNTU18_latest-zextras.tgz
EXTRACT_DIR=$(tar -tzf zcs-9.0.0_OSE_UBUNTU18_latest-zextras.tgz | head -1 | cut -f1 -d/)
cd $EXTRACT_DIR

# 5️⃣ Create Defaults File
cat <<EOF > /tmp/zimbra_install_defaults.txt
AVIS_DOMAINS=$DOMAIN_NAME
CREATE_ADMIN_USER=1
ADMIN_ACCOUNT=admin@$DOMAIN_NAME
ADMIN_PASSWORD=$ADMIN_PASSWORD
DOMAIN=$DOMAIN_NAME
AUTO_PROVISION_DOMAINS=$DOMAIN_NAME
RUN_POSTINSTALL=y
INSTALL_PACKAGES=zimbra-ldap zimbra-logger zimbra-mta zimbra-dnscache zimbra-snmp zimbra-store zimbra-apache zimbra-spell zimbra-memcached zimbra-proxy zimbra-drive zimbra-imapd zimbra-chat
EOF

# 6️⃣ Install Zimbra
chmod +x install.sh
export HOME=/home/ubuntu
export USER=ubuntu
export PATH=$PATH:/usr/sbin:/sbin
./install.sh --platform-override /tmp/zimbra_install_defaults.txt


