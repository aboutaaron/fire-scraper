class FiresController < ApplicationController

  # GET /fires
  # GET /fires.json
  def index
    @fires = County.find(params[:id])

    render json: @fires
  end

  # GET /fires/1
  # GET /fires/1.json
  def show
    @fire = Fire.find(params[:id])

    render json: @fire
  end

  # POST /fires
  # POST /fires.json
  def create
    @fire = Fire.new(params[:fire])

    if @fire.save
      render json: @fire, status: :created, location: @fire
    else
      render json: @fire.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fires/1
  # PATCH/PUT /fires/1.json
  def update
    @fire = Fire.find(params[:id])

    if @fire.update_attributes(params[:fire])
      head :no_content
    else
      render json: @fire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fires/1
  # DELETE /fires/1.json
  def destroy
    @fire = Fire.find(params[:id])
    @fire.destroy

    head :no_content
  end
end
