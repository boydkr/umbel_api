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

  context 'with associated brands' do
    let(:brand1) { Brand.create name: 'brand1'}
    let(:brand2) { Brand.create name: 'brand2'}
    subject { Profile.create name: 'Mr Man'}

    before do
      subject.brands<< brand1
      subject.brands<< brand2
    end

    it 'has associated brands' do
      expect(subject.brands.size).to eq(2)
      expect(subject.brands).to include brand1
    end

    it 'brand has associated profile' do
      expect(brand2.profiles).to include subject
    end
  end

end
