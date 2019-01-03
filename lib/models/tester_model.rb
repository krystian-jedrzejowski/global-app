require 'ffaker'

class TesterModel
  attr_accessor :first_name, :last_name, :email, :password, :gender, :birthday, :country, :post_code,
                :city, :payout_method, :payout_link, :communication_method, :language, :testing_preferences


  def with_random_data
    self.email = "#{SecureRandom.uuid}@mailinator.com"
    self.password = 'Test123!'
    self.first_name = Name.first_name
    self.last_name = Name.last_name
    self.gender = %w(female male).sample
    self.birthday = '01012000'
    self.country = 'Poland'
    self.city = AddressPL.city
    self.post_code = AddressPL.postal_code
    self.payout_method = 'Upwork'
    self.payout_link = 'http://test.upwork.com'
    self.communication_method = 'E-mail'
    self.language = 'Polish'
    self.testing_preferences = %w(functional usability load performance security).sample
    self
  end

  def email_prefix
    email.split('@')[0]
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end