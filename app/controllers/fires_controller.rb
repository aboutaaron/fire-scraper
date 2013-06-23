class FiresController < ApplicationController
  # GET /fires
  # GET /fires.json
  def index
    @fires = Fire.find(params[:county_id])

    render json: @fires
  end

  # GET /fires/1
  # GET /fires/1.json
  def show
    @fire = Fire.find(params[:id])

    render json: @fire
  end
end
