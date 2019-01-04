module PageObjects::TesterWork::Pages
  class SignUpPage < PageObjects::TesterWork::Page
    set_url '/tester-account/sign-up'

    section :email_form_group, :xpath, "//input[@name='email']/.." do
      element :input, 'input[name=email]'
      element :error, 'div.text-danger'
    end

    section :password_form_group, :xpath, "//input[@name='password']/.." do
      element :input, 'input[name=password]'
      element :error, 'div.text-danger'
    end

    section :password_confirmation_form_group, :xpath, "//input[@name='password_confirmation']/.." do
      element :input, 'input[name=password_confirmation]'
      element :error, 'div.text-danger'
    end

    section :terms_form_group,
            :xpath, "//input[@name='accepts_terms_and_conditions']/ancestor::div[contains(@class, 'form-group')]" do
      element :checkbox, 'input[name=accepts_terms_and_conditions]'
      element :error, 'div.text-danger'
    end

    element :sign_up_button, 'button[type=submit]'
    element :sign_up_error, 'div.text-danger'

    def sign_up(email, password, terms = true)
      email_form_group.input.send_keys email
      password_form_group.input.send_keys password
      password_confirmation_form_group.input.send_keys password
      terms_form_group.checkbox.set terms
      sign_up_button.click
    end
  end
end