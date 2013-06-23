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
end
