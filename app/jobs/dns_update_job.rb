require "dnsimple"
class DnsUpdateJob < ApplicationJob
  queue_as :default

  def client
    @client ||= Dnsimple::Client.new(access_token: Rails.application.credentials.simple_token)
  end
  def simple_id
      Rails.application.credentials.simple_id
  end
  def my_ip
    HTTParty.get("http://icanhazip.com").strip
  end

  def find_record(name , host)
    zones = client.zones.list_zone_records(simple_id, host, filter: { type: 'A' , name: name })
    zones.data.first
  end

  def update_ip
    record = find_record("gateway" , "hubfeenix.fi")
    client.zones.update_zone_record(simple_id,"hubfeenix.fi", record.id , content: my_ip)
  end
  def perform(*args)
  end
end
