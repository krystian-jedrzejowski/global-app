$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

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

TesterWork = PageObjects::TesterWork::Pages
Mailinator = PageObjects::Mailinator::Pages

Dir[File.expand_path('support/**/*.rb')].each { |f| require f }
Dir[File.expand_path('spec/scenarios/*.rb')].each { |f| require f }
Dir[File.expand_path('spec/shared_examples/*.rb')].each { |f| require f }

Config.load_and_set_settings('support/config/config.yml')

AllureRSpec.configure do |config|
  config.output_dir = 'reports/allure-results'
  config.clean_dir  = true
end

DriverHelper.new.initialize_driver(ENV['DRIVER'])

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

