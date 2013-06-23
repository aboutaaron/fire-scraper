class CountiesController < ApplicationController
  # GET /counties
  # GET /counties.json
  def index
    @counties = County.all

    render json: @counties
  end

  # GET /counties/1
  # GET /counties/1.json
  def show
    @county = County.find(params[:id])

    render json: @county
  end

  # POST /counties
  # POST /counties.json
  def create
    @county = County.new(params[:county])

    if @county.save
      render json: @county, status: :created, location: @county
    else
      render json: @county.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /counties/1
  # PATCH/PUT /counties/1.json
  def update
    @county = County.find(params[:id])

    if @county.update_attributes(params[:county])
      head :no_content
    else
      render json: @county.errors, status: :unprocessable_entity
    end
  end

  # DELETE /counties/1
  # DELETE /counties/1.json
  def destroy
    @county = County.find(params[:id])
    @county.destroy

    head :no_content
  end
end
