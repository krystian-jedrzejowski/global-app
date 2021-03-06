require_relative './spec_helper'

feature 'Sign In' do
  NOT_EXISTING_ACCOUNT_MSG =
    'This account doesn’t exist, try a different email/password or use ‘forgotten password’'.freeze
  INCORRECT_EMAIL_MSG = 'Please enter a valid email address'.freeze
  INVALID_EMAIL_MSG = 'is not a valid email'.freeze
  BLANK_PASSWORD_MSG = 'Password can not be left blank'.freeze

  let(:unconfirmed_account) { Settings.unconfirmed_account }

  feature 'negative scenarios' do
    include_examples 'sign in with incorrect email', '', INCORRECT_EMAIL_MSG
    include_examples 'sign in with incorrect email', 'test@test', INVALID_EMAIL_MSG

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
        login 'test@testwise.pl', 'Test123!'
        expect(@page).to have_login_error
        expect(login_error).to have_text NOT_EXISTING_ACCOUNT_MSG
      end
    end

    scenario 'should not login with incorrect password' do
      visit_page TesterWork::SignInPage do
        login unconfirmed_account.email, 'WrongPass1'
        expect(@page).to have_login_error
        expect(login_error).to have_text NOT_EXISTING_ACCOUNT_MSG
      end
    end
  end

  feature 'positive scenarios' do
    after(:each) { logout TesterWork::UnconfirmedAccountPage }

    scenario 'should login with signed up unconfirmed account' do
      visit_page TesterWork::SignInPage do
        login unconfirmed_account.email, unconfirmed_account.password
      end

      on_page TesterWork::UnconfirmedAccountPage do
        expect(navigation).to have_account_dropdown
      end
    end
  end
end
