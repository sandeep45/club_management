class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def ping
    render plain: "pong"
  end
end
