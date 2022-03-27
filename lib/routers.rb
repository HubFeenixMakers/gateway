require_relative "../config/application"
require "net/ssh"

class Routers

  @@start_address = "10.20.20."
  @@start_at = 20
  @@stop_at = 85

  def initialize
    @at = @@start_at
  end

  def at
    @@start_address + @at.to_s
  end

  # print info for each ip
  def print( info )
    info = "host_name" unless info
    each_router do |ip , connection|
      message = send(info.to_sym , connection)
      puts "#{ip} = #{message}"
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
    each_router do |ip , connection|
      connection.exec!(cron_create)
      connection.exec!(crond_restart)
      puts "Cron for #{ip} ok"
    end
  end

  def scan
    info = {}
    ips(false) do |ip , connection|
      if connection.is_a?(String)
        message = connection
      else
        info[ip] = get_info(connection)
        message = info[ip][:machine]
      end
      puts "#{ip} = #{message}"
    end
    r_file = File.open("#{Rails.root}/config/routers.yml" , "w")
    r_file.write(info.to_yaml)
    puts "Routers file written , #{info.length} live"
  end

  def each_router
    routers = YAML::load(File.open("#{Rails.root}/config/routers.yml"))
    routers.each do |ip ,info|
      connection = Net::SSH.start(ip , "root" ,
          password:  Rails.application.credentials.sala,
          non_interactive: true ,
          timeout: 4)
      yield( ip , connection)
      connection.close
    end
  end

  private
  # get the hostname from the connection
  # (as opposed to the admin network name)
  def host_name(connection)
    connection.exec!( "uci get system.@system[0].hostname").strip
  end

  # get the admin name, ie the dhcp name of the admin interface
  def admin_name(connection)
    connection.exec!( "uci get network.admin.hostname").strip
  end

  def cpuinfo(connection)
    connection.exec! "cat /proc/cpuinfo"
  end

  def machine(connection)
    cpuinfo(connection).lines[1].split(":")[1].strip
  end

  def get_info(connection)
    {machine: machine(connection) , host_name: admin_name(connection)}
  end
  # takes a block and yields ip and connection to
  # every succesful connection
  def ips(live_only = true)
    while(@at < @@stop_at)
      begin
        connection = Net::SSH.start(at , "root" ,
            password:  Rails.application.credentials.sala,
            non_interactive: true ,
            timeout: 4)
        yield( at , connection)
        connection.close
      rescue Net::SSH::ConnectionTimeout
        yield( at, "Timed out ssh") unless live_only
      rescue Errno::ETIMEDOUT
        yield( at, "Timed out Errno") unless live_only
      rescue Errno::EHOSTUNREACH
        yield( at, "Host unreachable") unless live_only
      rescue Errno::ECONNREFUSED
        yield( at, "Connection refused") unless live_only
      rescue Net::SSH::AuthenticationFailed
        yield( at, "Authentication failure") unless live_only
      end
      @at += 1
    end
  end

  #rudementary cli, dispatch on first arg, and pass rest
  def self.cli
    args = ARGV.dup
    command = args.shift
    routers = Routers.new
    routers.send(command , *args)
  end
end

Routers.cli
