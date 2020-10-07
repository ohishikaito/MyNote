# Gemfile.lockを見てcapistranoのバージョンを入れる
lock "~> 3.14.1"

# 自身のアプリ名、リポジトリ名を記述
set :application, 'MyNote'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:ohishikaito/MyNote.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

# chat-spaceで使ったpemを指定、どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/kaito_key_rsa']

# どの公開鍵を利用してデプロイするか
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :linked_files, %w{ config/master.key }
# master.key用のシンボリックリンクを追加
# set :linked_files, %w[config/master.key]

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end

  desc 'upload master.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      # circleCIでマスターキーを取得するためコメントアウト
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end