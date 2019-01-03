module PageObjects::TesterWork::Pages
  class SignInPage < PageObjects::TesterWork::Page
    set_url '/tester-account/sign-in'

    element :header, '.heading-group'

    section :email_form_group, :xpath, "//input[@name='email']/.." do
      element :input, 'input[name=email]'
      element :error, 'div.text-danger'
    end

    section :password_form_group, :xpath, "//input[@name='password']/.." do
      element :input, 'input[name=password]'
      element :error, 'div.text-danger'
    end

    element :login_button, 'button[type=submit]'
    element :login_error, 'div.text-danger'

    def login(username, password)
      email_form_group.input.send_keys username
      password_form_group.input.send_keys password
      login_button.click
    end
  end
end