# 構築手順
1. コンテナ作成
```
cp .env.sample .env
docker compose up -d
```

# 証明書発行
1. コンテナ内に入る。
```bash
winpty docker container exec -it myca ash
```

2. shを実行。
```bash
sh create_cert_use_san.sh
```

3. 発行された以下のファイルをバックエンドサーバーのお好みの場所に配置する。
```
server.crt
server.key
```
一般的に証明書（server.crt）は`/etc/ssl/certs`に配置するらしい。  
秘密鍵（server.key）は`/etc/ssl/private`、`/etc/pki/tls/private`に配置するらしい。

# フロント(Google Chrome)で使う方法
1. 設定→プライバシーとセキュリティ→セキュリティ→証明書の管理を開く
2. 配置したserver.crtを信頼されたルート証明機関として読込む
3. Chromeで開いているウインドウをすべて閉じる←大事
4. https://localhost:3000/ とかでローカル環境でアクセス。
