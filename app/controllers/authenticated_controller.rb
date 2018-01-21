class AuthenticatedController < ApplicationController

  before_action :authenticate_owner!
  before_action :set_owner

  protected

  def set_owner
    @owner = current_owner
  end

end
