root = Dir.getwd.to_s
bind 'tcp://0.0.0.0:9292'
pidfile "#{root}/tmp/puma/pid/puma.pid"
stdout_redirect "#{root}/tmp/puma/log/stdout", "#{root}/tmp/puma/log/stderr", true
