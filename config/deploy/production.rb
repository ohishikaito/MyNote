# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '3.113.216.56', user: 'kaito', roles: %w{app db web}