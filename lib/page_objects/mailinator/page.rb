module PageObjects::Mailinator
  class Page < SitePrism::Page
    load_validation { [displayed?, "Expected #{current_url} to match #{url_matcher} but it did not."] }

    def self.url
      "#{Settings.mailinator_url}#{@url}"
    end
  end
end