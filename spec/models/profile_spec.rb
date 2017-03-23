require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validations' do
    subject { Profile.new }
    it { is_expected.to be_valid }
  end

  context 'with name' do
    subject { Profile.create name: "Mr Man" }

    it { is_expected.to be_valid }
    it 'has a name' do
      expect(subject.name).to eq('Mr Man')
    end
  end
end
