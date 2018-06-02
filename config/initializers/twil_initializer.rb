Twil.configure do |config|
  config.from_phone_number = ENV['FROM_PHONE_NUMBER']
  config.to_phone_number = ENV['TO_PHONE_NUMBER']
  config.twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
  config.twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']
end
