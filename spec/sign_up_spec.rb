require_relative './spec_helper'

feature 'SignUp' do
  CONFIRM_EMAIL_TEXT = 'Please confirm your email address for Tester Work'.freeze
  VERIFY_EMAIL_SUBJECT = 'Please verify your email address'.freeze
  EMPTY_EMAIL_MSG = 'Must be a valid email address'.freeze
  EMPTY_PASSWORD_MSG = 'Password can not be left blank'.freeze
  INVALID_EMAIL_MSG = 'is not a valid email'.freeze
  TAKEN_EMAIL_MSG = 'has already been taken'.freeze
  SHORT_PASSWORD_MSG = 'is too short (minimum is 8 characters)'.freeze
  INVALID_PASSWORD_MSG = 'must contain big, small letters and digits'.freeze
  PASSWORD_NOT_MATCH_MSG = 'This must match the Password above'.freeze
  ACCEPT_TERMS_MSG = 'Please accept the Tester Work Terms of Service before continuing'.freeze
  CONFIRMED_ACCOUNT_MSG = 'Your email address %s has been confirmed. '\
    'Please log in to complete your account setup.'.freeze


  feature 'negative scenarios' do
    include_examples 'sign up with incorrect email', '', EMPTY_EMAIL_MSG
    include_examples 'sign up with incorrect email', 'test@test', INVALID_EMAIL_MSG
    include_examples 'sign up with incorrect email', 'test@test.com', TAKEN_EMAIL_MSG

    include_examples 'sign up with incorrect password', '', EMPTY_PASSWORD_MSG
    include_examples 'sign up with incorrect password', 'short', SHORT_PASSWORD_MSG
    include_examples 'sign up with incorrect password', 'eightcha', INVALID_PASSWORD_MSG
    include_examples 'sign up with incorrect password', 'withdig1', INVALID_PASSWORD_MSG
    include_examples 'sign up with incorrect password', 'withCapi', INVALID_PASSWORD_MSG

    scenario 'should show error if terms unchecked' do
      visit_page TesterWork::SignUpPage do
        sign_up "#{SecureRandom.uuid}@test.com", 'Whatever1', false
        expect(terms_form_group).to have_error
        expect(terms_form_group.error).to have_text ACCEPT_TERMS_MSG
      end
    end

    scenario 'should show error if confirmation password does not match' do
      visit_page TesterWork::SignUpPage do
        email_form_group.input.send_keys "#{SecureRandom.uuid}@test.com"
        password_form_group.input.send_keys 'Whatever1'
        password_confirmation_form_group.input.send_keys 'Whatever2'
        terms_form_group.checkbox.set true
        sign_up_button.click
        expect(password_confirmation_form_group).to have_error
        expect(password_confirmation_form_group.error).to have_text PASSWORD_NOT_MATCH_MSG
      end
    end
  end

  feature 'positive scenarios' do
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
end