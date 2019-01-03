module CommonScenarios
  extend RSpec::SharedContext

  VERIFY_EMAIL_SUBJECT = 'Please verify your email address'.freeze

  def sign_up(tester)
    visit_page TesterWork::SignUpPage do
      sign_up(tester.email, tester.password)
    end

    on_page TesterWork::AccountCreatedPage, email: tester.email

    visit_page Mailinator::InboxPage, email: tester.email_prefix do
      open_email VERIFY_EMAIL_SUBJECT
    end

    token = on_page Mailinator::VerifyEmailPage, email: tester.email_prefix do
      confirmation_token
    end

    visit_page TesterWork::ConfirmRegistrationPage, token: token

    on_page TesterWork::SignInPage do
      login(tester.email, tester.password)
    end
  end

  def login(tester)
    visit_page TesterWork::SignInPage do
      login(tester.email, tester.password)
    end
  end

  def logout(current_page)
    on_page current_page do
      navigation.logout
    end
  end
end