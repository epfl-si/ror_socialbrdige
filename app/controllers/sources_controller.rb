class SourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_source, only: [:show, :edit, :update, :refresh, :destroy]

  # --------------------------------------------------------------------- CUSTOM

  # GET /auth/:provider/callback
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
      redirect_to sources_path
    else
      raise "Error"
    end
  end

  # ----------------------------------------------------------------------- REST
  # GET /sources
  def index
    @sources = current_user.sources.order(:type).includes(:requests)
    @missing_sources = Source.providers - @sources.map{|s| s.class}
    # @requests = current_user.requests
  end

  # GET /sources/new
  def new
    @source = current_user.sources.new
    @providers = Source.providers.select{|p| p::AUTH_TYPE != :oauth}.map{|p| p.name}
    if params["provider"]
      @source.type = params["provider"]
    end
  end

  # POST /sources
  def create
    @source = current_user.sources.new(params["source"].permit(["type", "uid", "key"]))
    if @source.save
      redirect_to sources_path
    else
      render action: "new"
    end
  end

  # GET /sources/:id
  def show
    @requests = @source.requests
  end

  # GET /sources/:id/edit
  def edit
    if @source.auth_type == :oauth
      redirect_back(fallback_location: sources_path)
    end
  end

  # PUT /sources/:id
  def update
    @source.update_attributes(params['source'].permit(["key", "uid"]))
    if @source.save
      redirect_to sources_path
    else
      render action: "edit"
    end
  end

  # DELETE /sources/:id
  def destroy
    @source.destroy
    redirect_back(fallback_location: sources_path)
  end

  # ------------------------------------------------------------------ Utilities

  def set_and_authorize_source
    @source = Source.find(params[:id])
    authorize! :manage, @source
  end

end
