require "dns_update_job"
namespace :dns do
  desc "Update own dyn dns records"
  task update: :environment do
    job = DnsUpdateJob.new
    puts "My ip is #{job.my_ip}"
    job.update_ip("gateway" , "hubfeenix.fi")
  end

end
