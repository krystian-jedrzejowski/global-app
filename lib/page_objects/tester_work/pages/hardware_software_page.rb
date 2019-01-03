module PageObjects::TesterWork::Pages
  class HardwareSoftwarePage < PageObjects::TesterWork::Page
    set_url '/tester-account/registration/hardware-software'

    section :navigation, NavigationSection
    element :desktop_tab, '#hardware-and-software-tabs-tab-1'
    element :mobile_tab, '#hardware-and-software-tabs-tab-2'
    section :desktop_devices, DesktopDevicesSection
    section :mobile_devices, MobileDevicesSection
  end
end