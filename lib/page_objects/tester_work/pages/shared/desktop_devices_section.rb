require_relative './select_section'

class DesktopDevicesSection < SitePrism::Section
  set_default_search_arguments '#hardware-and-software-tabs-pane-1'

  SELECT_XPATH = "//label/span[contains(text(),'%s')]/../..".freeze

  element :add_device_button, :xpath, "//button[contains(text(), 'Add another desktop device')]"
  section :os_selection, SelectSection, :xpath, format(SELECT_XPATH, 'Operating System')
  element :save_button, 'button', text: 'Save'
  element :cancel_button, 'button', text: 'Cancel'

  sections :os_items, '.success-element' do
    element :name, 'p>strong'
    element :edit_button, 'button>.fa-pencil'
    element :delete_button, 'button>.fa-trash'
  end

  def find(operating_system)
    os_items.find { |os_item| os_item.name.text.eql? operating_system }
  end

  def add(os_name)
    add_device_button.click
    os_selection.send_keys os_name
    save_button.click
  end

  def edit(old_os_name, new_os_name)
    find(old_os_name).edit_button.click
    os_selection.send_keys new_os_name
    save_button.click
  end

  def delete(os_name)
    find(os_name).delete_button.click
  end
end