#!/bin/bash

#variables
TF_DB_USER="tf_user"
TF_DB_PASS="tf_password"
TF_DB_NAME="tf_state"
CONTROLLER_IP="${controller_ip}"


dnf update -y
dnf install -y postgresql-server postgresql-contrib

# inizializzazione database 
postgresql-setup --initdb
systemctl enable postgresql
systemctl start postgresql

# Creazione DB e utente per Terraform
sudo -u postgres psql <<EOF
CREATE USER $TF_DB_USER WITH PASSWORD '$TF_DB_PASS';
CREATE DATABASE $TF_DB_NAME OWNER $TF_DB_USER;
EOF

# Configurazione accesso remoto limitato
PG_CONF="/var/lib/pgsql/data/postgresql.conf"
PG_HBA="/var/lib/pgsql/data/pg_hba.conf"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF
echo "host all all $CONTROLLER_IP/32 md5" >> $PG_HBA

systemctl restart postgresql

# Installazione Docker 
dnf install -y yum-utils
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io

# Avvio Docker
systemctl enable docker
systemctl start docker

echo "PostgreSQL + Docker pronti. DB: $TF_DB_NAME, User: $TF_DB_USER, accesso solo da $CONTROLLER_IP"
