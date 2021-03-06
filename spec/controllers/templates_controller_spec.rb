require 'rails_helper'

describe TemplatesController do
  let(:actions) do
    [ 'pages/show', 'welcome/index' ]
  end

  it 'does not render any layout' do
    actions.each do |action_name|
      get :show, id: action_name
      expect(response).to be_success
      expect(response).to_not render_template /layout/
      expect(response).to render_template action_name
    end
  end

  it 'renders the template specified in the id' do
    actions.each do |action_name|
      get :show, id: action_name
      expect(response).to be_success
      expect(response).to render_template action_name
    end
  end
end
