module PageObjects::TesterWork::Pages
  class SignUpPage < PageObjects::TesterWork::Page
    set_url '/tester-account/sign-up'

    element :email_input, 'input[name=email]'
    element :password_input, 'input[name=password]'
    element :password_confirmation_input, 'input[name=password_confirmation]'
    element :terms_checkbox, 'input[name=accepts_terms_and_conditions]'
    element :sign_up_button, 'button[type=submit]'

    def sign_up(username, password)
      email_input.send_keys username
      password_input.send_keys password
      password_confirmation_input.send_keys password
      terms_checkbox.set true
      sign_up_button.click
    end
  end
end