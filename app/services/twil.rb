module Twil
  extend ActiveSupport::Concern

  included do
    after_update :text_update, if: :state_has_changed_to_done
  end

  class Configuration
    include Singleton

    attr_accessor :from_phone_number, :to_phone_number, :twilio_account_sid, :twilio_auth_token
  end

  # for configuring the "global" settings (account_sid, phone numbers, auth_token)
  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
    Configuration.instance
  end

  # for accessing configuration needed at the class instance level
  def config
    Configuration.instance
  end

  def state_has_changed_to_done
    state_changed? && done?
  end

  def text_update
    @client = Twilio::REST::Client.new config.twilio_account_sid, config.twilio_auth_token
    @client.api.account.messages.create(
      from: config.from_phone_number,
      to: config.to_phone_number,
      body: "Task: #{self.name}, state: #{self.state}"
    )
  end
end
