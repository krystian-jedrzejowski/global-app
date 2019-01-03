$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

#require 'wts'
#include WTS::Capybara
# require 'wts/spec'
# include WTS::Spec
# require 'wts/retry'
# require 'wts/allure'

require 'allure-rspec'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'ffaker'
require 'config'

require 'page_objects_dsl'
require 'page_objects/tester_work'
require 'page_objects/mailinator'
require 'models/tester_model'


include FFaker

TesterWork = PageObjects::TesterWork::Pages
Mailinator = PageObjects::Mailinator::Pages

Dir[File.expand_path('spec/scenarios/*.rb')].each { |f| require f }
Dir[File.expand_path('spec/shared_examples/*.rb')].each { |f| require f }

# Set configuration according to environment
Config.load_and_set_settings('support/config/config.yml')


AllureRSpec.configure do |config|
  config.output_dir = 'reports/allure-results'
  config.clean_dir  = true
end

capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
capabilities['url'] = "http://localhost:4444/wd/hub"

Capybara.register_driver :remote_browser do |app|
  Capybara::Selenium::Driver.new(
      app,
    browser: :remote,
    desired_capabilities: capabilities
  )
end

Capybara.configure do |config|
  config.default_driver = :remote_browser
  config.javascript_driver = :remote_browser
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.include AllureRSpec::Adaptor
  config.include PageObjects::DSL
  config.include ::Capybara::DSL, type: :feature
  config.include ::Capybara::RSpecMatchers, type: :feature
  config.include CommonScenarios

  config.after(:each) do |test|
    unless test.exception.nil?
      tmp = File.new(page.save_screenshot(File.join(Dir.pwd, "tmp/capybara/#{UUID.new.generate}.png")))
      test.attach_file('screenshot', tmp)
      File.unlink(tmp)
    end
  end
end

