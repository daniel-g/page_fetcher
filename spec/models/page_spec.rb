require 'rails_helper'

describe Page do
  it{ respond_to :uid }
  it{ respond_to :username }

  it 'stores a page with uid and username' do
    Page.create!(uid: '1234', username: 'Test')
    expect(Page.count).to eq 1
    page = Page.first
    expect(page.uid).to eq '1234'
    expect(page.username).to eq 'Test'
  end
end
