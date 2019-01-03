class NavigationSection < SitePrism::Section
  set_default_search_arguments 'nav.navbar'

  element :account_dropdown, '#account-dropdown'
  element :logout_button, 'a', text: 'Log Out'

  def logout
    account_dropdown.click
    logout_button.click
  end
end