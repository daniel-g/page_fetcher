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

  it 'creates a page if it is found' do
    expect_any_instance_of(Koala::Facebook::API).to(
      receive(:get_object)
    ).with(fb_object_id).and_return(fb_object_attributes)
    expect(Page).to receive(:create!).with(page_attributes).and_return(Page.new(page_attributes))
    post :create, id: fb_object_id, format: :json
    expect(response).to be_success
  end

  it 'returns an error code if the page does not exist' do
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
