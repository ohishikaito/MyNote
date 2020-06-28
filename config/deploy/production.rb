# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '3.113.216.56', user: 'kaito', roles: %w{app db web}

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, auth_methods: ['publickey'],
                  keys: '~/.ssh/mynote_key_rsa',
                  forward_agent: true