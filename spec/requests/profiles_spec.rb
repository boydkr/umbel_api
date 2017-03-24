require 'rails_helper'

RSpec.describe "Profiles", type: :request do
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

  describe 'GET /profiles' do

    context 'no query params' do
      subject! { get profiles_path(), {} }

      it 'responds with 200' do
        expect(response).to have_http_status(200)
      end

      it 'has the root key' do
        expect(json).to include('profiles')
      end

      it 'includes the existing profiles' do
        profiles = json['profiles']

        expect(profiles.length).to eq(2)

        ids = profiles.map { |v| v['id'].to_i }
        expect(ids).to include(profile1.id)
        expect(ids).to include(profile2.id)
      end
    end

    context 'with query param' do

      subject! { get profiles_path(), { brand: brand2.id } }

      it 'responds with 200' do
        expect(response).to have_http_status(200)
      end

      it 'has the root key' do
        expect(json).to include('profiles')
      end

      it 'includes the matching profile' do
        profiles = json['profiles']

        expect(profiles.length).to eq(1)

        ids = profiles.map { |v| v['id'].to_i }
        expect(ids).to include(profile2.id)
      end
    end
  end

  describe 'POST /profiles' do
    subject! { post profiles_path(), { profile: {name: 'new_profile'}} }

    it 'responds with 201' do
      expect(response).to have_http_status(201)
    end

    it 'has an assigned id' do
      expect(json['profile']).to include('id')
    end

    it 'has the given name' do
      expect(json['profile']['name']).to eq('new_profile')
    end

    it 'expects another profile to exist' do
      expect(Profile.all.size).to eq(3)
    end
  end

  describe 'PUT /profiles/1' do
    subject! { put profile_path(profile1), { profile: {name: 'new_name'}} }

    it 'responds with 204' do
      expect(response).to have_http_status(204)
    end

    it 'expects the profile to be updated' do
      expect(Profile.find(profile1.id).name).to eq('new_name')
    end
  end

  describe 'POST /profiles/1/add_brand' do
    subject! { post add_brand_profile_path(profile1), {brand: brand2.id} }

    it 'responds with 204' do
      expect(response).to have_http_status(200)
    end

    it 'expects the profile to include the brand' do
      expect(Profile.find(profile1.id).brands).to include(brand2)
    end
  end

  describe 'POST /profiles/1/remove_brand' do
    subject! { post remove_brand_profile_path(profile2), {brand: brand2.id} }

    it 'responds with 204' do
      expect(response).to have_http_status(200)
    end

    it 'expects the profile to include the brand' do
      expect(Profile.find(profile2.id).brands).not_to include(brand2)
    end
  end
end
