require_relative './select_section'

class MobileDevicesSection < SitePrism::Section
  set_default_search_arguments '#hardware-and-software-tabs-pane-2'

  SELECT_XPATH = "//label/span[contains(text(),'%s')]/../.."

  element :add_device_button, :xpath, "//button[contains(text(), 'Add another device')]"

  section :manufacturer_selection, SelectSection, :xpath, format(SELECT_XPATH, 'Manufacturer')
  section :model_selection, SelectSection, :xpath, format(SELECT_XPATH, 'Device model')
  section :os_selection, SelectSection, :xpath, format(SELECT_XPATH, 'Operating System')
  element :save_button, 'button', text: 'Save'
  element :cancel_button, 'button', text: 'Cancel'

  sections :device_items, '.success-element' do
    element :name, 'p>strong'
    element :os, :xpath, './/p[2]'
    element :edit_button, 'button>.fa-pencil'
    element :delete_button, 'button>.fa-trash'
  end

  def find(manufacturer, model)
    device_items.find { |device_item| device_item.name.text.eql? "#{manufacturer} #{model}"}
  end

  def add(manufacturer, model, os)
    add_device_button.click
    manufacturer_selection.send_keys manufacturer
    model_selection.send_keys model
    os_selection.send_keys os
    save_button.click
  end

  def edit(act_manufacturer, act_model, new_manufacturer, new_model, new_os)
    find(act_manufacturer, act_model).edit_button.click
    manufacturer_selection.send_keys new_manufacturer
    model_selection.send_keys new_model
    os_selection.send_keys new_os
    save_button.click
  end

  def delete(manufacturer, model)
    find(manufacturer, model).delete_button.click
  end
end