module PageObjects::TesterWork::Pages
end

require 'page_objects/tester_work/page'

Dir[File.dirname(__FILE__) + '/pages/shared/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |file| require file }