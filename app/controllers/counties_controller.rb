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

  # GET /counties/1/fires
  # GET /counties/1/fires.json
  def show_fires
    county = County.find(params[:id])

    @county_fires = county.fires.find_by_county_id(county.id)

    render json: @county_fires
  end
end
