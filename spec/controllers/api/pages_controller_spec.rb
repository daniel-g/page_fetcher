require 'rails_helper'

describe Api::PagesController, 'POST#create' do
  let(:fb_object_id){ '12345' }

  let(:page_attributes) do
    {
      uid: '12345', username: 'Test'
    }
  end
  let(:fb_object_attributes) do
    {'id' => '12345', 'username' => 'Test' }
  end

  it 'creates a page if it is found on Facebook' do
    expect_any_instance_of(Koala::Facebook::API).to(
      receive(:get_object)
    ).with(fb_object_id).and_return(fb_object_attributes)
    expect(Page).to receive(:create!).with(page_attributes).and_return(Page.new(page_attributes))
    post :create, id: fb_object_id, format: :json
    expect(response).to be_success
  end

  it 'returns an error code if the page does not exist on Facebook' do
    not_found_error = Koala::Facebook::ClientError.new('404', '')
    expect_any_instance_of(Koala::Facebook::API).to(
      receive(:get_object)
    ).with(fb_object_id).and_raise(not_found_error)
    expect(Page).to_not receive(:create!)
    post :create, id: fb_object_id, format: :json
    expect(response).to_not be_success
    expect(response).to render_template('api/errors/not_found')
  end
end

describe Api::PagesController, 'GET#show' do
  let(:page_id) { 1 }

  let(:fb_object_id){ '12345' }

  let(:page_attributes) do
    {
      uid: '12345', username: 'Test'
    }
  end

  let(:fb_page_feed) do
    [
      { 'message' => 'Main message' },
      { 'message' => 'Secondary message' },
      { 'message' => 'Third message' }
    ]
  end

  it 'retrieves a page feed if it is found' do
    expect_any_instance_of(Koala::Facebook::API).to(
      receive(:get_connection)
    ).with(fb_object_id, 'feed').and_return(fb_page_feed)
    expect(Page).to receive(:find).with(page_id.to_s).and_return(Page.new(page_attributes))
    get :show, id: page_id, format: :json
    expect(response).to be_success
  end

  it 'returns an error code if the page does not exist' do
    not_found_error = Mongoid::Errors::DocumentNotFound.new(Page, '')
    expect(Page).to receive(:find).with(page_id.to_s).and_raise(not_found_error)
    get :show, id: page_id, format: :json
    expect(response).to_not be_success
    expect(response).to render_template('api/errors/not_found')
  end
end

describe Api::PagesController, 'GET#index' do
  render_views

  let(:pages) do
    [
      Page.new( { uid: '12345', username: 'Test' }),
      Page.new( { uid: '12346', username: 'Test2' })
    ]
  end

  it 'retrieves the list of created pages' do
    expect(Page).to receive(:all).and_return(pages)
    get :index, format: :json
    expect(response).to be_success
    expect(response).to render_template 'api/pages/index'
    expect(api_response).to eql [
      { id: pages.first.id.to_s, uid: '12345', username: 'Test' },
      { id: pages.last.id.to_s, uid: '12346', username: 'Test2' }
    ].as_json
  end
end
