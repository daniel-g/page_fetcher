class Api::PagesController < Api::ApplicationController
  attr_accessor :page
  helper_method :page

  def create
    self.page = Page.create!(uid: fb_page['id'], username: fb_page['username'])
  end

  private

  def fb_page
    @fb_page ||= fb_api.get_object(params[:id])
  end

  def fb_api
    @fb_api ||= Koala::Facebook::API.new(Rails.application.secrets.fb_access_token)
  end
end
