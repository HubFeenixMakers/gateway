require_relative "../config/application"
require "net/ssh"

class Routers

  @@start_address = "10.20.20."
  @@start_at = 30
  @@stop_at = 80

  def initialize
    @at = @@start_at
  end

  def at
    @@start_address + @at.to_s
  end

  def for_each command_string
    # find
    # connect
    # run command
  end

  def all_ips
    connections = {}
    while(@at < @@stop_at)
      error = nil
      begin
        connection = Net::SSH.start(at , "root" ,
            password:  Rails.application.credentials.sala,
            non_interactive: true ,
            timeout: 4)
        puts "Ok #{at}"
        connections[at] = connection
      rescue Net::SSH::ConnectionTimeout
        error = "  Timed out ssh"
      rescue Errno::ETIMEDOUT
        error = "  Timed out erro"
      rescue Errno::EHOSTUNREACH
        error = "  Host unreachable"
      rescue Errno::ECONNREFUSED
        error = "  Connection refused"
      rescue Net::SSH::AuthenticationFailed
        error = "  Authentication failure"
      end
      puts "not at #{at} #{error}" if error
      @at += 1
    end
  end

end
Routers.new.all_ips
