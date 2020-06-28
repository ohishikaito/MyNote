# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '13.114.24.148', user: 'ec2-user', roles: %w{app db web}