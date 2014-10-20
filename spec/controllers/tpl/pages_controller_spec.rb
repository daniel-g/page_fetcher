require 'rails_helper'
require 'controllers/tpl/shared_examples_for_template_controllers'

describe Tpl::PagesController do
  it_behaves_like 'template controller' do
    let(:actions) do
      [ :show, :index ]
    end
  end
end
