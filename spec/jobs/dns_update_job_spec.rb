require 'rails_helper'
require "dns_update_job"

RSpec.describe DnsUpdateJob, type: :task do

  it "update ip" do
    updater = DnsUpdateJob.new
    updater.update_ip("dnsimple_test","hubfeenix.fi")
    zone = updater.find_record("dnsimple_test","hubfeenix.fi")
    expect(zone.content).to eq updater.my_ip
  end

  it "should get ip" do
    res = DnsUpdateJob.new.my_ip
    expect(res).to start_with "84"
  end

  it "should init client" do
    client = DnsUpdateJob.new.client
    expect(client.class).to be Dnsimple::Client
  end

  it "should find domain" do
    updater = DnsUpdateJob.new
    zone = updater.find_record("dnsimple_test","hubfeenix.fi")
    expect(zone.class).to eq Dnsimple::Struct::ZoneRecord
    expect(zone.name).to eq "dnsimple_test"
    expect(zone.content).to eq updater.my_ip
  end
end
