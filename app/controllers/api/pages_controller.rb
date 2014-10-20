class Api::PagesController < Api::ApplicationController
  attr_accessor :page, :feed
  helper_method :page, :feed

  def create
    self.page = Page.create!(uid: fb_page['id'], username: fb_page['username'])
  end

  def show
    self.page = Page.find(params[:id])
    self.feed = fb_page_feed
    render json: feed
  end

  private

  def fb_page_feed
    @fb_page_feed ||= fb_api.get_connection(page.uid, 'feed')
  end

  def fb_page
    @fb_page ||= fb_api.get_object(params[:id])
  end

  def fb_api
    @fb_api ||= Koala::Facebook::API.new(Rails.application.secrets.fb_access_token)
  end
end
