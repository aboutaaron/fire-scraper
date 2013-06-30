class FiresController < ApplicationController
  # GET /fires
  # GET /fires.json
  def index
    @fires = Fire.all
    render json: @fires
  end

  # GET /fires/1
  # GET /fires/1.json
  def show
    @fires = Fires.find(params[:id])
    render json: @fires
  end
end
