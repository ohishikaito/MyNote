# 元々の記述は全て削除して大丈夫です
require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/rails/console'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }