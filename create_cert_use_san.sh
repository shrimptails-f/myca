#!/bin/sh

# 秘密鍵の生成
openssl genrsa -out /etc/pki/cert/${SECRET_FILE_NAME} 2048


# CSRの生成
openssl req -new -key /etc/pki/cert/${SECRET_FILE_NAME} \
  -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/CN=${COMMON_NAME}" \
  -out /etc/pki/cert/server.csr

# 自己署名証明書の生成
openssl x509 -req -days 365 \
  -in /etc/pki/cert/server.csr \
  -signkey /etc/pki/cert/${SECRET_FILE_NAME} \
  -out /etc/pki/cert/${CERT_FILE_NAME} \
  -extfile subjectnames.txt
