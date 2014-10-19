require 'rails_helper'

describe 'Pages API' do
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
