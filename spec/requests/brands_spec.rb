require 'rails_helper'

RSpec.describe "Brands", type: :request do
  let(:profile1) { Profile.create(name: "profile1") }
  let(:profile2) { Profile.create(name: "profile2") }
  let(:brand1) { Brand.create(name: "brand1") }
  let(:brand2) { Brand.create(name: "brand2") }

  let(:json) { JSON.parse(response.body) }

  before do
    profile1.brands<< brand1
    profile2.brands<< brand1
    profile2.brands<< brand2
  end

  describe 'GET /brands' do

    subject! { get brands_path(), {} }

    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end

    it 'has the root key' do
      expect(json).to include('brands')
    end

    it 'includes the existing profiles' do
      brands = json['brands']

      expect(brands.length).to eq(2)

      ids = brands.map { |v| v['id'].to_i }
      expect(ids).to include(brand1.id)
      expect(ids).to include(brand2.id)
    end

  end

  describe 'POST /brands' do
    subject! { post brands_path(), { brand: {name: 'new_brand'}} }

    it 'responds with 201' do
      expect(response).to have_http_status(201)
    end

    it 'has an assigned id' do
      expect(json['brand']).to include('id')
    end

    it 'has the given name' do
      expect(json['brand']['name']).to eq('new_brand')
    end

    it 'expects another profile to exist' do
      expect(Brand.all.size).to eq(3)
    end
  end

  describe 'PUT /brands/1' do
    subject! { put brand_path(brand1), { brand: {name: 'new_name'}} }

    it 'responds with 204' do
      expect(response).to have_http_status(204)
    end

    it 'expects the profile to be updated' do
      expect(Brand.find(brand1.id).name).to eq('new_name')
    end
  end
end
