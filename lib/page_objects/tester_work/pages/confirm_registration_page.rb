module PageObjects::TesterWork::Pages
  class ConfirmRegistrationPage < PageObjects::TesterWork::Page
    set_url '/tester-account/confirm-registration/{token}'
    set_url_matcher %r{tester-account/sign-in}
  end
end