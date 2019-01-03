module PageObjects::TesterWork
  class Page < SitePrism::Page
    load_validation { [displayed?, "Expected #{current_url} to match #{url_matcher} but it did not."] }

    SELECT_BY_LABEL_NAME_XPATH_1 = "//label/span[contains(text(),'%s')]/../..".freeze
    SELECT_BY_LABEL_NAME_XPATH_2 = "//label/span/p[contains(text(),'%s')]/../../..".freeze

    def self.url
      "#{Settings.testerwork_url}#{@url}"
    end

    def wait_for(condition, check_frequency = 0.15, max_wait_time = Capybara.default_max_wait_time)
      Timeout.timeout(max_wait_time) do
        sleep check_frequency until condition.call
      end
    end
  end
end