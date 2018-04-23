class Api::RequestsController < ApplicationController
  before_action :set_request
  respond_to :json

  # GET /api/requests/:id/refresh
  def refresh
    if @request.fetch!
      render :json => @request.result, :status => 200
    else
      render :json => { error: "Internal error" }, :status => 500
    end
  end

  # ----------------------------------------------------------------------- REST
  # GET /api/requests/:id
  def show
    render json: @request.result
  end
  def set_request
    @request = Request.where(token: params[:id]).first
    if @request.nil?
      render :json => {:error => "internal-server-error"}, :status => 404
    end
  end

end
