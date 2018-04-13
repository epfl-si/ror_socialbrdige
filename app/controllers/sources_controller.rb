class SourcesController < ApplicationController
  before_action :authenticate_user!

  def new
    @source = current_user.sources.new
    @providers = Source.providers.select{|p| p::AUTH_TYPE != :oauth}.map{|p| p.name}
    if params["provider"]
      @source.type = params["provider"]
    end
  end

  def create
    @source = current_user.sources.new(params["source"].permit(["type", "uid", "key"]))
    if @source.save
      redirect_to user_path(current_user)
    else
      render action: "new"
    end
  end

  def create_or_update_from_oauth
    data=env["omniauth.auth"]
    t = current_user.sources.where(type: data["provider"].capitalize, uid: data["uid"]).first
    unless t
      t = current_user.sources.new
      t.type = data['provider'].capitalize
      t.uid  = data['uid']
    end
    t.data=data
    puts t.inspect
    if t.save
      redirect_to user_path(current_user)
    else
      raise "Error"
    end
  end

  def show
    @source = current_user.sources.find(params[:id])
    @requests = @source.requests
  end

  # # DELETE /sources/1
  # def destroy
  #   @request.destroy
  #   redirect_back(fallback_location: source_path(@source))
  # end



end
