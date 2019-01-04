shared_examples 'sign up with incorrect email' do |email, error_mgs|
  scenario "should show error if incorrect email '#{email}'" do
    visit_page TesterWork::SignUpPage do
      sign_up email, 'Whatever'
      expect(email_form_group).to have_error
      expect(email_form_group.error).to have_text error_mgs
    end
  end
end

shared_examples 'sign up with incorrect password' do |password, error_mgs|
  scenario "should show error if incorrect email '#{password}'" do
    visit_page TesterWork::SignUpPage do
      sign_up 'test@test.com', password
      expect(password_form_group).to have_error
      expect(password_form_group.error).to have_text error_mgs
    end
  end
end