#!/bin/sh
#author songtianyi630@163.com

KEY_DIR=/home/usr1/pki/
if [ ! -d $KEY_DIR ]; then
    mkdir $KEY_DIR 
fi
cd /home/usr1/pki/

CA_KEY=ca-key.pem
CA_CERT=ca-cert.pem
SUBJ="/C=CN/L=LIAONING/O=DALIAN-NATIONALITIES-UNIVERSITY/CN=VDI-CA"
SERVER_KEY=server-key.pem
SERVER_KEY_CSR=server-key.csr
SERVER_CERT=server-cert.pem


# create a key for CA 
openssl genrsa -des3 -out $CA_KEY 1024
#get an unsecured key
openssl rsa -in $CA_KEY -out $CA_KEY.unsecure
# create CA 
openssl req -new -x509 -days 7300 -key $CA_KEY.unsecure -out $CA_CERT -subj $SUBJ




#create server key
openssl genrsa -des3 -out $SERVER_KEY 1024
#get an unsecured key
openssl rsa -in $SERVER_KEY -out $SERVER_KEY.unsecure
#create a certificate signing request (csr)
openssl req -new -key $SERVER_KEY.unsecure -out $SERVER_KEY_CSR -subj $SUBJ 



#signing server key with CA to get a server certificate 
openssl x509 -req -days 1095 -in $SERVER_KEY_CSR -CA $CA_CERT -CAkey $CA_KEY.unsecure -set_serial 01 -out $SERVER_CERT
#remove csr and unsecured files
rm -f $SERVER_KEY_CSR
#rm -f $SERVER_KEY.unsecure
rm -f $CA_KEY.unsecure
mv $SERVER_KEY $SERVER_KEY.secure
mv $SERVER_KEY.unsecure $SERVER_KEY

#echo --host-subject
echo "your --host-subject is" \"`openssl x509 -noout -text -in server-cert.pem | grep Subject: | cut -f 10- -d " "`\"
#usage
echo "copy ca-cert.pem to %APPDATA%\spicec\spice_truststore.pem or ~/.spice/spice_truststore.pem in your clients"
