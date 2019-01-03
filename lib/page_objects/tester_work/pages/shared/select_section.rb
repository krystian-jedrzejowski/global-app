class SelectSection < SitePrism::Section
  element :expand_selection, 'div.Select'
  element :input, '.Select-input>input'
  elements :options, '.Select-menu>.Select-option'

  def send_keys(value)
    expand_selection.click
    input.send_keys value
    options.find { |option| option.text.eql? value }.click
  end
end