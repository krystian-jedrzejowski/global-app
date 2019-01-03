require_relative './spec_helper'

feature 'Login' do
  NOT_EXISTING_ACCOUNT_MSG = 'This account doesn’t exist, try a different email/password or use ‘forgotten password’'
  INCORRECT_EMAIL_MSG = 'Please enter a valid email address'
  INVALID_EMAIL_MSG = 'is not a valid email'
  BLANK_PASSWORD_MSG = 'Password can not be left blank'

  include_examples 'incorrect email', ''         , INCORRECT_EMAIL_MSG
  include_examples 'incorrect email', 'test@test', INVALID_EMAIL_MSG

  scenario 'should show error if empty password' do
    visit_page TesterWork::SignInPage do
      email_form_group.input.send_keys 'a@b.co'
      login_button.click
      expect(password_form_group).to have_error
      expect(password_form_group.error).to have_text BLANK_PASSWORD_MSG
    end
  end

  scenario 'should not login with not exising account' do
    visit_page TesterWork::SignInPage do
      login  'test@testwise.pl',  'Test123!'
      expect(@page).to have_login_error
      expect(login_error).to have_text NOT_EXISTING_ACCOUNT_MSG
    end
  end
end
