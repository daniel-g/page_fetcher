require 'rails_helper'
require 'controllers/tpl/template_controllers_spec'

describe Tpl::PagesController do
  it_behaves_like 'template controller' do
    let(:actions) do
      [ :show, :index ]
    end
  end
end
