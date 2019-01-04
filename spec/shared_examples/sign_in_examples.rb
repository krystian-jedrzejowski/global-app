shared_examples 'sign in with incorrect email' do |email, error_mgs|
  scenario "should show error if incorrect email '#{email}'" do
    visit_page TesterWork::SignInPage do
      login email, 'Whatever'
      expect(email_form_group).to have_error
      expect(email_form_group.error).to have_text error_mgs
    end
  end
end