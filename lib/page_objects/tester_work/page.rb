module PageObjects::TesterWork
  class Page < SitePrism::Page
    load_validation { [displayed?, "Expected #{current_url} to match #{url_matcher} but it did not."] }

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