require 'rails_helper'

describe 'Pages API' do
  describe 'index' do
    it 'retrieves the index of created pages' do
      Page.create!(uid: '188091757763', username: 'Tigerlilyapps')
      Page.create!(uid: '188091757764', username: 'Tigerlilyapps2')
      get api_pages_path(format: :json)
      expect(response).to be_success
      expect(api_response.length).to eq 2
      expect(api_response.first.uid).to eq 188091757763
      expect(api_response.last.uid).to eq 188091757764
    end
  end

  describe 'creation' do
    it 'creates a page' do
      VCR.use_cassette('create page') do
        post api_pages_path(id: '188091757763', format: :json)
      end
      expect(response).to be_success
      expect(api_response['username']).to eq 'Tigerlilyapps'
      expect(api_response['uid']).to eq '188091757763'
    end

    it 'resposes with 404 if the page was not found' do
      VCR.use_cassette('create not found page') do
        post api_pages_path(id: '18809175776a', format: :json)
      end
      expect(response).to be_not_found
      expect(api_response['message']).to be_present
    end
  end

  describe 'showing' do
    it 'retrieves the feed of a page' do
      page = Page.create!(uid: '188091757763', username: 'Tigerlilyapps')
      VCR.use_cassette('show page feed') do
        get api_page_path(id: page.id.to_s, format: :json)
      end
      expect(response).to be_success
      expect(api_response.length).to be > 0
    end

    it 'resposes with 404 if the page feed was not found' do
      page = Page.create!(uid: '188091757763', username: 'Tigerlilyapps')
      VCR.use_cassette('show not found page feed') do
        get api_page_path(id: 111111, format: :json)
      end
      expect(response).to be_not_found
    end
  end
end
