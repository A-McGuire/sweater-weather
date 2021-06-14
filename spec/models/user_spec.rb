require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { User.new(email: 'validations_test', password: '123verysafe') }
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password_digest}
  end
end