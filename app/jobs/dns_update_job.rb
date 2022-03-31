require "dnsimple"
class DnsUpdateJob < ApplicationJob
  def self.get_client
    Dnsimple::Client.new(access_token: Rails.application.credentials.simple_token)
  end
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
