require 'selenium-webdriver'
require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, options: {
      browser: :remote,
      url: ENV.fetch('SELENIUM_DRIVER_URL'),
      desired_capabilities: :chrome
    }
    Capybara.server_host = ENV.fetch('CAPYBARA_SERVERHOST') { '127.0.0.1' }
    Capybara.server_port = 3000
    Capybara.app_host = "http://#{Capybara.server_host}:3000"
  end
end
