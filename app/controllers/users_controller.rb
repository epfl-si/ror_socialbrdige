class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to user_path(current_user)
  end

  def show
    @sources = current_user.sources.order(:type).includes(:requests)
    @missing_sources = Source.providers - @sources.map{|s| s.class}
    # @requests = current_user.requests
  end
end
