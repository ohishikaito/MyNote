# ../が一つ増えている
app_path = File.expand_path('../../../', __FILE__)
# unicornがエラー吐いたので直接ディレクトリを指定
# app_path = File.expand_path('/var/www/MyNote')

worker_processes 1
# currentを指定
working_directory "#{app_path}/current"

# それぞれ、sharedの中を参照するよう変更
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

#Railsアプリケーションの応答を待つ上限時間を設定
timeout 60

#以下は応用的な設定なので説明は割愛

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end

# # ファイルが無いのでconfigフォルダにunicorn.rbを新規作成します

# app_path = File.expand_path('../../../', __FILE__)
# # 上記からEC2からunicornを再起動可能にするために修正(6/29) 問題があれば上記に戻す
# # app_path = File.expand_path('/var/www/MyNote')

# worker_processes 1

# working_directory "#{app_path}/current"
# pid "#{app_path}/shared/tmp/pids/unicorn.pid"
# listen "#{app_path}/shared/tmp/sockets/unicorn.sock"
# stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
# stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

# timeout 60

# preload_app true
# GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

# check_client_connection false

# run_once = true

# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) &&
#     ActiveRecord::Base.connection.disconnect!

#   if run_once
#     run_once = false # prevent from firing again
#   end

#   old_pid = "#{server.config[:pid]}.oldbin"
#   if File.exist?(old_pid) && server.pid != old_pid
#     begin
#       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
#       Process.kill(sig, File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH => e
#       logger.error e
#     end
#   end
# end

# after_fork do |_server, _worker|
#   defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
# end