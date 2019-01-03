require_relative './spec_helper'

feature 'Hardware and software' do
  let(:tester) { TesterModel.new.with_random_data }
  let(:desktop_device) { 'Windows 10' }
  let(:desktop_device_edit) { 'OSX 10.10 Yosemite' }
  let(:mobile_device) { { manufacturer: 'Samsung', model: 'Galaxy S6', os: 'Android 5.0 Lollipop' } }
  let(:mobile_device_edit) { { manufacturer: 'Huawei', model: 'P10', os: 'Android 8.0 Oreo' } }

  before(:each) { sign_up tester }
  after(:each) { logout TesterWork::HardwareSoftwarePage }

  scenario 'should add/edit desktop device' do
    on_page TesterWork::AccountSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::TestingSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::HardwareSoftwarePage do
      desktop_devices.add desktop_device
      expect(desktop_devices.find(desktop_device)).not_to be_nil
      expect(desktop_devices.os_items.count).to eql 1

      desktop_devices.edit desktop_device, desktop_device_edit
      expect(desktop_devices.find(desktop_device)).to be_nil
      expect(desktop_devices.find(desktop_device_edit)).not_to be_nil
      expect(desktop_devices.os_items.count).to eql 1
    end
  end

  # Skipped due to the bug: Cannot delete if only one device - console error 422
  xscenario 'should add/delete desktop device' do
    on_page TesterWork::AccountSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::TestingSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::HardwareSoftwarePage do
      desktop_devices.add desktop_device
      expect(desktop_devices.find(desktop_device)).not_to be_nil
      expect(desktop_devices.os_items.count).to eql 1

      desktop_devices.delete desktop_device
      desktop_devices.wait_until_os_items_invisible
      expect(desktop_devices.os_items.count).to eql 0
    end
  end

  scenario 'should add/edit/delete mobile device' do
    on_page TesterWork::AccountSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::TestingSettingsPage do
      fill_in_required_fields tester
      continue
    end

    on_page TesterWork::HardwareSoftwarePage do
      # Add initial device to avoid bug described in ticket above
      desktop_devices.add desktop_device

      mobile_tab.click

      # Add Mobile Device
      mobile_devices.add mobile_device[:manufacturer], mobile_device[:model], mobile_device[:os]

      act_device = mobile_devices.find mobile_device[:manufacturer], mobile_device[:model]
      expect(act_device).not_to be_nil
      expect(act_device.os).to have_text mobile_device[:os]
      expect(mobile_devices.device_items.count).to eql 1

      # Edit Mobile Device
      mobile_devices.edit mobile_device[:manufacturer], mobile_device[:model],
                          mobile_device_edit[:manufacturer], mobile_device_edit[:model],
                          mobile_device_edit[:os]

      expect(mobile_devices.find(mobile_device[:manufacturer], mobile_device[:model])).to be_nil
      edited_device = mobile_devices.find mobile_device_edit[:manufacturer], mobile_device_edit[:model]
      expect(edited_device).not_to be_nil
      expect(edited_device.os).to have_text mobile_device_edit[:os]
      expect(mobile_devices.device_items.count).to eql 1

      # Delete Mobile Device
      mobile_devices.delete mobile_device_edit[:manufacturer], mobile_device_edit[:model]
      mobile_devices.wait_until_device_items_invisible
      expect(mobile_devices.device_items.count).to eql 0
    end
  end
end