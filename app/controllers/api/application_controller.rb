class Api::ApplicationController < ApplicationController
  rescue_from Koala::Facebook::ClientError, with: :not_found
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  def not_found
    render '/api/errors/not_found', status: :not_found
  end
end
