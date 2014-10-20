class Tpl::PagesController < Tpl::ApplicationController
  def show
    render action: params[:id]
  end
end
