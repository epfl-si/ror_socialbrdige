class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:show_by_token, :refresh_by_token]
  before_action :set_and_authorize_request, only: [:show, :edit, :update, :refresh, :destroy]
  respond_to :html

  def refresh
    if @request.fetch!
      flash = { success: "Request data refreshed" }
    else
      flash = { error: "Request data could not be refreshed" }
    end
    redirect_back(fallback_location: source_path(@source))
  end

  # ----------------------------------------------------------------------- REST
  # GET /requests/:id
  def show
  end

  # GET /requests/:id/edit
  def edit
  end

  # PUT /requests/:id
  def update
    @request.update_attributes(permitted_params)
    if @request.save
      redirect_to source_path(@source)
    else
      render action: :edit
    end

  end

  # GET /sources/:source_id/new
  def new
    @source = Source.find(params[:source_id])
    authorize! :manage, @source
    @request = @source.requests.new
    if params[:duplicate]
      m = @source.requests.find(params[:duplicate])
      @request.path = m.path
      @request.query = m.query
      @request.selection = m.selection
    end
  end

  # POST /sources/:source_id/requests
  def create
    @source  = Source.find(params[:source_id])
    # authorize! :manage, @source
    @request = @source.requests.new(permitted_params)
    if @request.save
      redirect_to source_path(@source)
    else
      # puts "err not saved: #{@request.to_yaml}"
      render action: :new
    end
  end

  # DELETE /requests/:id
  def destroy
    @request.destroy
    redirect_back(fallback_location: source_path(@source))
  end

  # ------------------------------------------------------------------ Utilities

  def set_and_authorize_request
    @request = Request.find(params[:id])
    @source  = @request.source
    authorize! :manage, @source
  end

  def permitted_params
    params["request"].permit([:description, :query, :path, :selection, :agemax])
  end
end
