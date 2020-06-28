# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '13.114.24.148', user: 'kaito', roles: %w{app db web}