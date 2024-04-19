#!/bin/sh

# 秘密鍵の生成
openssl genrsa -out /etc/pki/cert/${SECRET_FILE_NAME} 2048

# 自己署名証明書の生成（SANにホスト名を含む）
openssl req -new -x509 -nodes -sha256 -days 365 \
  -key /etc/pki/cert/${SECRET_FILE_NAME} \
  -out /etc/pki/cert/${CERT_FILE_NAME} \
  -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/CN=${COMMON_NAME}" \
  -addext "subjectAltName=DNS:${HOST}"

openssl req -new -key /etc/pki/cert/${SECRET_FILE_NAME} -subj "/C=JP/ST=Some-State/O=Some-Org/CN=localhost" > server.csr

# 署名要求を秘密鍵で署名してサーバ証明書を作成する
openssl x509 -days 3650 -req -extfile subjectnames.txt -signkey /etc/pki/cert/${SECRET_FILE_NAME} < server.csr > /etc/pki/cert/${CERT_FILE_NAME}