module PageObjects::TesterWork::Pages
  class UnconfirmedAccountPage < PageObjects::TesterWork::Page
    set_url '/tester-account/registration/unconfirmed-account'

    section :navigation, NavigationSection
  end
end