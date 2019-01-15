class DriverHelper

  def initialize_driver(driver)
    case driver
    when 'chrome'
      chrome
    when 'remote_chrome'
      remote_chrome
    when 'remote_firefox'
      remote_firefox
    else
      chrome
    end
  end

  private

  def chrome
    local_browser :chrome
  end

  def remote_chrome
    remote_browser Selenium::WebDriver::Remote::Capabilities.chrome
  end

  def remote_firefox
    remote_browser Selenium::WebDriver::Remote::Capabilities.firefox
  end

  def local_browser(browser)
    Capybara.register_driver :browser do |app|
      Capybara::Selenium::Driver.new(app, browser: browser)
    end

    Capybara.configure do |config|
      config.default_driver = :browser
      config.javascript_driver = :browser
      config.default_max_wait_time = 5
    end
  end

  def remote_browser(capabilities)
    Capybara.register_driver :remote_browser do |app|
      Capybara::Selenium::Driver.new(
          app,
          browser: :remote,
          url: 'http://selenium-hub:4444/wd/hub',
          desired_capabilities: capabilities
      )
    end

    Capybara.configure do |config|
      config.default_driver = :remote_browser
      config.javascript_driver = :remote_browser
      config.default_max_wait_time = 5
    end
  end
end