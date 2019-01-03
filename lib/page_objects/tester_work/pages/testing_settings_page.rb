module PageObjects::TesterWork::Pages
  class TestingSettingsPage < PageObjects::TesterWork::Page
    set_url '/tester-account/registration/testing-settings'

    SELECT_XPATH = "//label/span[contains(text(),'%s')]/../.."

    section :navigation, NavigationSection

    element :continue_button, 'button', text: 'Continue'

    section :testing_preferences, :xpath, "//label/span/p[contains(text(),'Testing preferences')]/../../.."do
      elements :checkboxes, '.button-checkboxes>label'

      def select(preference)
        checkboxes.find { |checkbox| checkbox.text.eql? preference }.click
      end
    end

    section :language_selection, SelectSection, :xpath, format(SELECT_XPATH,'Native language')

    load_validation { has_testing_preferences? }

    def fill_in_required_fields(tester_model)
      testing_preferences.select tester_model.testing_preferences
      language_selection.send_keys tester_model.language
    end

    def continue
      continue_button.click
    end
  end
end