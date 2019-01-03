module PageObjects::Mailinator::Pages
end

require 'page_objects/mailinator/page'

Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |file| require file }