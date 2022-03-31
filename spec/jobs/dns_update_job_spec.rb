require 'rails_helper'

RSpec.describe DnsUpdateJob, type: :job do
  ActiveJob::Base.queue_adapter = :test
  let(:my_ip){"85.76.133.88"}

  it "should get ip" do
    res = DnsUpdateJob.new.my_ip
    expect(res).to eq my_ip
  end

  it "should init client" do
    client = DnsUpdateJob.new.client
    expect(client.class).to be Dnsimple::Client
  end

  it "should find domain" do
    zone = DnsUpdateJob.new.find_record("gateway","hubfeenix.fi")
    expect(zone.class).to eq Dnsimple::Struct::ZoneRecord
    expect(zone.name).to eq "gateway"
    expect(zone.content).to eq my_ip
  end

  it "update ip" do
    updater = DnsUpdateJob.new
    updater.update_ip
    zone = updater.find_record("gateway","hubfeenix.fi")
    expect(zone.content).to eq my_ip
  end
end
