require 'spec_helper'

describe User do
  context 'create' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'has successfully created a user' do
      expect(user.email).not_to be_nil
    end
  end
end
