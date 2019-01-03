require_relative './spec_helper'

feature 'SignUp' do
  CONFIRM_EMAIL_TEXT = 'Please confirm your email address for Tester Work'
  VERIFY_EMAIL_SUBJECT = 'Please verify your email address'
  CONFIRMED_ACCOUNT_MSG = 'Your email address %s has been confirmed. '\
    'Please log in to complete your account setup.'

  let(:tester) { TesterModel.new.with_random_data }

  after(:each) { logout TesterWork::AccountSettingsPage }

  scenario 'should sign up correctly' do
    visit_page TesterWork::SignUpPage do
      sign_up(tester.email, tester.password)
    end

    on_page TesterWork::AccountCreatedPage, email: tester.email do
      expect(header).to have_text CONFIRM_EMAIL_TEXT
    end

    visit_page Mailinator::InboxPage, email: tester.email_prefix do
      open_email VERIFY_EMAIL_SUBJECT
    end

    token = on_page Mailinator::VerifyEmailPage, email: tester.email_prefix do
      confirmation_token
    end

    visit_page TesterWork::ConfirmRegistrationPage, token: token

    on_page TesterWork::SignInPage do
      expect(header).to have_text format(CONFIRMED_ACCOUNT_MSG, tester.email)
      login(tester.email, tester.password)
    end

    on_page TesterWork::AccountSettingsPage do
      expect(navigation).to have_account_dropdown
    end
  end
end