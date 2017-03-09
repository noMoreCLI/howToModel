#!/bin/bash

# Declare variables for certificate gen
export CERT_DIR="/usr/local/osmosix/cert"
export COUNTRY="CH"
export STATE="ZH"
export CITY="Zurich"
export ORG="CECLABS"
export ORG_UNIT="Sales"
export COMMON_NAME="nextcloud.cisco.com"

# Prepare certificates for HTTPS
sudo mkdir -p $CERT_DIR
sudo openssl req -nodes -newkey rsa:2048 -keyout $CERT_DIR/private.key -out $CERT_DIR/CSR.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=$COMMON_NAME"
sudo openssl rsa -in $CERT_DIR/private.key -out $CERT_DIR/vm.cliqr.com.key
sudo openssl x509 -in $CERT_DIR/CSR.csr -out $CERT_DIR/vm.cliqr.com.cert -req -signkey $CERT_DIR/vm.cliqr.com.key
sudo cp $CERT_DIR/vm.cliqr.com.cert $CERT_DIR/vm.cliqr.com.crt

