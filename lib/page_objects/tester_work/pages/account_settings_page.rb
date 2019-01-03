module PageObjects::TesterWork::Pages
  class AccountSettingsPage < PageObjects::TesterWork::Page
    set_url '/tester-account/registration/account-settings'

    section :navigation, NavigationSection

    SELECT_XPATH = "//label/span[contains(text(),'%s')]/../.."

    element :first_name_input, 'input[name=first_name]'
    element :last_name_input, 'input[name=last_name]'
    element :birthday_input, 'input[name=birthday]'
    element :city_input, 'input[name=city]'
    element :post_code_input, 'input[name=postcode]'
    element :payout_input, 'input[name=payout_method_identifier]'
    element :continue_button, 'button', text: 'Continue'

    section :country_selection, SelectSection, :xpath, "//label/span/p[contains(text(),'Country')]/../../.."
    section :communication_selection, SelectSection, :xpath, format(SELECT_XPATH,'Preferred Communication Method')
    section :payout_selection, SelectSection, :xpath, format(SELECT_XPATH,'Payout method')

    section :gender_selection, :xpath, format(SELECT_XPATH,'Gender')do
      element :expand_selection, 'div.Select'
      elements :options, '.Select-menu>.Select-option'

      def select(value)
        expand_selection.click
        options.find { |option| option.text.eql? value }.click
      end
    end

    load_validation { has_continue_button? }

    def fill_in_required_fields(tester_model)
      first_name_input.send_keys tester_model.first_name
      last_name_input.send_keys tester_model.last_name
      gender_selection.select tester_model.gender
      birthday_input.send_keys tester_model.birthday
      country_selection.send_keys tester_model.country
      post_code_input.send_keys tester_model.post_code
      communication_selection.send_keys tester_model.communication_method
      payout_selection.send_keys tester_model.payout_method
      payout_input.send_keys tester_model.payout_link
    end

    def continue
      continue_button.click
    end
  end
end