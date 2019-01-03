shared_examples 'incorrect email' do |email, error_mgs|
  scenario "should show error if incorrect email '#{email}'" do
    visit_page TesterWork::SignInPage do
      email_form_group.input.send_keys email
      password_form_group.input.send_keys 'Whatever'
      login_button.click
      expect(email_form_group).to have_error
      expect(email_form_group.error).to have_text error_mgs
    end
  end
end