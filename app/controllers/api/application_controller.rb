class Api::ApplicationController < ApplicationController
  rescue_from Koala::Facebook::ClientError, with: :not_found
  rescue_from Koala::Facebook::AuthenticationError, with: :session_expired
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  def not_found
    render '/api/errors/not_found', status: :not_found
  end

  def session_expired
    render '/api/errors/session_expired', status: 400
  end
end
