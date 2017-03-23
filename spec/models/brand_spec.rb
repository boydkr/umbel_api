require 'rails_helper'

RSpec.describe Brand, type: :model do

  context 'validations' do
    subject { Brand.new }
    it { is_expected.to be_valid }
  end

  context 'with name' do
    subject { Brand.create name: 'Test Co' }

    it { is_expected.to be_valid }
    it 'has a name' do
      expect(subject.name).to eq('Test Co')
    end
  end
end
