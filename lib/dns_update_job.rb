require "dnsimple"
class DnsUpdateJob

  def client
    @client ||= Dnsimple::Client.new(access_token: Rails.application.credentials.simple_token)
  end
  def simple_id
      Rails.application.credentials.simple_id
  end
  def my_ip
    @ip ||= HTTParty.get("https://jsonip.com/")["ip"]
  end

  def find_record(name , host)
    zones = client.zones.list_zone_records(simple_id, host, filter: { type: 'A' , name: name })
    zones.data.first
  end

  def same_ip(name , host)
    my_ip == find_record(name , host).content
  end

  def update_ip(name , host)
    record = find_record(name , host)
    client.zones.update_zone_record(simple_id, host , record.id , content: my_ip)
  end
end
