module PageObjects::TesterWork::Pages
  class AccountCreatedPage < PageObjects::TesterWork::Page
    set_url '/tester-account/account-created/{email}'
    set_url_matcher %r{tester-account/account-created\/.+@.+}

    element :header, 'h2'

    load_validation { has_header? }
  end
end