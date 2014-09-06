require 'redis'
require 'fileutils'

class Redis
  def self.object
    Module.new do
      def self.included base
        chain = base.to_s.split '::'
        path  = "/tmp/ruby.#{$$}/#{chain.join '/'}"
        FileUtils.mkdir_p path

        redis_conf = %!
          port 0
          unixsocket #{path}/redis.sock
        !
        IO.write "#{path}/redis.conf", redis_conf

        redis_pid = fork { exec "redis-server #{path}/redis.conf" }

        redis_instance = Redis.new path: "#{path}/redis.sock"
        base.const_set :R, redis_instance

        at_exit do
          %x! kill #{redis_pid} !
        end

        20.times do
          begin
            sleep 0.1
            break if base::R.ping == 'PONG'
          rescue Errno::EISCONN
            next
          end
        end
      end
    end
  end
end
