require_relative "../config/application"
require "net/ssh"

class Routers

  @@start_address = "10.20.20."
  @@start_at = 43
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

  # takes a block and yields ip and connectio to
  # every succesful connection
  def all_ips
    while(@at < @@stop_at)
      begin
        connection = Net::SSH.start(at , "root" ,
            password:  Rails.application.credentials.sala,
            non_interactive: true ,
            timeout: 4)
        puts "Ok #{at}"
        yield( at , connection)
        break
      rescue Net::SSH::ConnectionTimeout
        puts "Not at #{at}  Timed out ssh"
      rescue Errno::ETIMEDOUT
        puts "Not at #{at}  Timed out erro"
      rescue Errno::EHOSTUNREACH
        puts "Not at #{at}  Host unreachable"
      rescue Errno::ECONNREFUSED
        puts "Not at #{at}  Connection refused"
      rescue Net::SSH::AuthenticationFailed
        puts "Not at #{at}  Authentication failure"
      end
      @at += 1
    end
  end

  # create a reboot at 2:30
  # destructively in the same location,
  # ie can rerun to ensure, but other changes will be lost
  def make_cron
    # Reboot at 2:30am every day
    # Note: To avoid infinite reboot loop, wait 70 seconds
    # and touch a file in /etc so clock will be set
    # properly to 2:31 on reboot before cron starts.
    cron_job = "30 2 * * * sleep 70 && touch /etc/banner && reboot"
    cron_file = "/etc/crontabs/root"
    cron_create = "echo '#{cron_job}' > #{cron_file}"
    crond_restart = "/etc/init.d/cron restart"
    all_ips do |ip , connection|
      connection.exec!(cron_create)
      connection.exec!(crond_restart)
      puts "Cron for #{ip} ok"
    end
  end
end
Routers.new.make_cron
