require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!


  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  config.before(:each, type: :system) do
    driven_by :remote_chrome
    Capybara.server_host = '0.0.0.0'
    Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', 3001).to_i
    Capybara.app_host = "http://web:#{Capybara.server_port}"
  end
end

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://selenium:4444/wd/hub",
    options: options
  )
end
